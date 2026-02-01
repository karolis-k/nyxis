import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

import '../config/item_config.dart';
import '../config/location_config.dart';
import '../config/monster_config.dart';
import '../core/event_bus.dart';
import '../core/events.dart';
import '../models/entities/entity.dart';
import '../models/entities/item.dart';
import '../models/entities/monster.dart';
import '../models/entities/player.dart';
import '../models/game_state.dart';
import '../models/world/location.dart';
import '../models/world/tile.dart';
import '../config/portal_registry.dart';
import '../models/entities/portal.dart';
import '../models/entities/world_object.dart';
import '../services/generation/generation.dart';
import '../services/generation/generator_registry.dart';
import '../services/generation/portal_placement.dart';
import '../services/pathfinding_service.dart';
import '../services/save_service.dart';
import 'components/item_component.dart';
import 'components/monster_component.dart';
import 'components/player_component.dart';
import 'components/tile_component.dart';
import 'systems/combat_system.dart';
import 'systems/monster_behavior_system.dart';
import 'systems/turn_system.dart';

/// Main game class for the roguelike game.
///
/// Wires Flame rendering to the backend systems (TurnSystem, CombatSystem,
/// MonsterBehaviorSystem) and manages the game loop.
class MyGame extends FlameGame with HasKeyboardHandlerComponents, PanDetector {
  /// Tile size in pixels.
  static const double tileSize = 32.0;

  /// Default map dimensions for dungeon generation.
  static const int defaultMapWidth = 50;
  static const int defaultMapHeight = 40;

  /// The location config ID to use for this game instance.
  final String locationId;

  /// Callback to exit to the world map (called when using stairs up on floor 1).
  final VoidCallback? onExitToWorldMap;

  /// Creates a new game instance for the specified location.
  MyGame({
    required this.locationId,
    this.onExitToWorldMap,
  });

  // Backend systems
  late final TurnSystem turnSystem;
  late final CombatSystem combatSystem;
  late final MonsterBehaviorSystem monsterBehaviorSystem;
  late final PathfindingService pathfindingService;
  late final EventBus eventBus;

  // World object components
  final Map<String, SpriteComponent> _worldObjectComponents = {};

  // Current game state (nullable until onLoad completes)
  GameState? _gameStateInternal;

  // Random generator for floor generation (seeded for consistency)
  late final Random _random;

  // Flame components
  PlayerComponent? _playerComponent;
  final Map<String, MonsterComponent> _monsterComponents = {};
  final Map<String, ItemComponent> _itemComponents = {};

  // Event subscriptions
  final List<StreamSubscription> _subscriptions = [];

  /// Callback for floor changes (used by HUD to update floor indicator).
  void Function(int floor)? onFloorChanged;

  /// Callback when game state changes (used by UI to update).
  VoidCallback? onStateChanged;

  /// Whether the camera is currently manually controlled (panned by user).
  bool _isManualCameraControl = false;

  /// Timer for snapping back to player after manual panning.
  double _snapBackTimer = 0.0;

  /// Duration before camera snaps back to player after panning.
  static const double snapBackDelay = 1.5;

  /// Gets the current game state (throws if accessed before onLoad completes).
  GameState get gameState {
    if (_gameStateInternal == null) {
      throw StateError('Game state accessed before initialization');
    }
    return _gameStateInternal!;
  }

  /// Sets the game state internally.
  set _gameState(GameState value) => _gameStateInternal = value;

  /// Gets the current game state, or null if not initialized.
  GameState? get gameStateOrNull => _gameStateInternal;

  /// Gets the current floor number (returns 0 if game not ready).
  int get currentFloor => _gameStateInternal?.currentFloor ?? 0;

  /// Whether the game is ready (state initialized).
  bool get isReady => _gameStateInternal != null;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Register configurations
    MonsterRegistry.registerAll();
    LocationRegistry.registerAll();
    ItemRegistry.registerAll();
    PortalRegistry.registerAll();
    GeneratorRegistry.registerAll();

    // Preload all sprites for performance
    await _preloadSprites();

    // Initialize random generator with a seed for consistent floor generation
    _random = Random();

    // Initialize services
    pathfindingService = PathfindingService();
    eventBus = EventBus.instance;

    // Initialize systems
    combatSystem = CombatSystem(eventBus: eventBus);
    monsterBehaviorSystem = MonsterBehaviorSystem(pathfindingService);
    turnSystem = TurnSystem(combatSystem, monsterBehaviorSystem, eventBus: eventBus);

    // Try to load existing save, or create new game
    final loadedState = await _tryLoadSave();
    if (loadedState != null) {
      _gameState = loadedState;
    } else {
      _gameState = _createGameState();
    }

    // Subscribe to events
    _setupEventListeners();

    // Create tile components
    _createTileComponents();

    // Create player component
    _createPlayerComponent();

    // Create monster components
    _createMonsterComponents();

    // Create item components
    _createItemComponents();

    // Create world object components (portals, etc.)
    _createWorldObjectComponents();

    // Set up camera to follow player
    _setupCamera();

    // Fire game started event
    eventBus.fire(GameStartedEvent());
  }

  /// Preloads all sprite assets for performance.
  ///
  /// Uses Flame's built-in image cache so components can use fromCache().
  Future<void> _preloadSprites() async {
    await images.loadAll([
      // Player/entity sprites
      'icons/entities/human.png',
      'icons/entities/dwarf.png',
      'icons/entities/elf.png',
      'icons/entities/village_elder.png',
      // Monster sprites
      'icons/monsters/goblin.png',
      'icons/monsters/orc.png',
      'icons/monsters/dragon.png',
      'icons/monsters/fairy.png',
      // Item sprites
      'icons/items/sword.png',
      'icons/items/armor.png',
      'icons/items/potion.png',
      'icons/items/helmet.png',
      'icons/items/boots.png',
      'icons/items/medieval-leather-pants.png',
      'icons/items/stone.png',
      // Tile sprites
      'icons/tiles/stone-floor.png',
      'icons/tiles/stone-wall.png',
      'icons/tiles/stair-down.png',
      'icons/tiles/stair-down-overlay.png',
      'icons/tiles/stair-up.png',
      'icons/tiles/stair-up-overlay.png',
      'icons/tiles/water.png',
      'icons/tiles/grass.png',
      'icons/tiles/portal.png',
    ]);
  }

  /// Tries to load an existing save.
  Future<GameState?> _tryLoadSave() async {
    try {
      final exists = await SaveService.instance.saveExists('autosave');
      if (!exists) return null;

      final loadedState = await SaveService.instance.loadGame('autosave');
      if (loadedState == null) return null;

      // Only load if the game was in playing state
      if (loadedState.status == GameStatus.playing) {
        return loadedState;
      }
      return null;
    } catch (e) {
      debugPrint('Failed to load save: $e');
      return null;
    }
  }

  /// Creates a game state with a procedurally generated dungeon.
  GameState _createGameState() {
    final random = Random();
    final config = LocationRegistry.get(locationId);

    // Get the appropriate generator for this location type
    final generator = GeneratorRegistry.get(config.generatorType);

    // Generate the dungeon (starting at floor 0)
    var location = generator.generate(
      config: config,
      floor: 0,
      random: random,
    );

    // Create portals for this floor
    final portals = PortalPlacement.createPortals(
      location,
      config.id,
      0,
      random,
    );
    final worldObjects = <String, WorldObject>{};
    final worldObjectIds = <String>[];
    for (final portal in portals) {
      worldObjects[portal.id] = portal;
      worldObjectIds.add(portal.id);
    }

    // Update location with world object IDs
    location = location.copyWith(worldObjectIds: worldObjectIds);

    // Find player spawn position (near stairs up, or first floor tile)
    final playerSpawn = _findPlayerSpawn(location);

    // Create player at spawn position
    final player = Player.create(
      position: playerSpawn,
      maxHealth: 100,
      attack: 10,
      defense: 5,
    );

    // Spawn monsters at random floor positions
    final monsters = _spawnMonsters(location, config, playerSpawn, random);
    final monsterIds = monsters.keys.toList();

    // Collect used positions (monsters)
    final usedPositions = monsters.values
        .map((m) => m.position)
        .toSet();

    // Spawn items at random floor positions
    final items = _spawnItems(location, config, playerSpawn, usedPositions, random);
    final itemIds = items.keys.toList();

    // Update location with monster and item IDs
    final locationWithEntities = location.copyWith(
      monsterIds: monsterIds,
      itemIds: itemIds,
      visited: true,
    );

    // Create game state with 0-based floor indexing
    return GameState(
      player: player,
      currentLocationId: locationWithEntities.id,
      currentFloor: 0,
      locations: {locationWithEntities.id: locationWithEntities},
      monsters: monsters,
      items: items,
      worldObjects: worldObjects,
      turnNumber: 0,
      isPlayerTurn: true,
      status: GameStatus.playing,
      isOnWorldMap: false,
    );
  }

  /// Finds a valid spawn position for the player.
  Position _findPlayerSpawn(Location location) {
    final map = location.map;

    // Look for stairs up first
    final stairsUp = map.findTilesByType(TileType.stairsUp);
    if (stairsUp.isNotEmpty) {
      final stair = stairsUp.first;
      return Position(x: stair.x, y: stair.y);
    }

    // Fall back to first walkable tile
    for (var y = 0; y < map.height; y++) {
      for (var x = 0; x < map.width; x++) {
        if (map.isWalkable(x, y)) {
          return Position(x: x, y: y);
        }
      }
    }

    // Absolute fallback
    return const Position(x: 5, y: 5);
  }

  /// Spawns monsters in the dungeon.
  Map<String, Monster> _spawnMonsters(
    Location location,
    LocationConfig config,
    Position playerSpawn,
    Random random,
  ) {
    final monsters = <String, Monster>{};
    final walkableTiles = location.map.walkableTiles;

    // Filter out tiles too close to player spawn
    final validSpawns = walkableTiles.where((pos) {
      final dx = (pos.x - playerSpawn.x).abs();
      final dy = (pos.y - playerSpawn.y).abs();
      return dx + dy > 5; // At least 5 tiles away
    }).toList();

    if (validSpawns.isEmpty || config.monsterPool.isEmpty) {
      return monsters;
    }

    // Spawn 3-6 monsters
    final monsterCount = 3 + random.nextInt(4);
    final usedPositions = <({int x, int y})>{};

    for (var i = 0; i < monsterCount && validSpawns.isNotEmpty; i++) {
      // Pick a random spawn position
      final spawnIndex = random.nextInt(validSpawns.length);
      final spawn = validSpawns[spawnIndex];

      // Skip if position already used
      if (usedPositions.contains(spawn)) continue;
      usedPositions.add(spawn);

      // Pick a random monster type from the pool
      final configId = config.monsterPool[random.nextInt(config.monsterPool.length)];
      final monsterConfig = MonsterRegistry.tryGet(configId);
      if (monsterConfig == null) continue;

      // Create the monster
      final monster = Monster.create(
        configId: configId,
        position: Position(x: spawn.x, y: spawn.y),
        maxHealth: monsterConfig.baseHealth,
      );
      monsters[monster.id] = monster;
    }

    return monsters;
  }

  /// Spawns items in the dungeon.
  Map<String, Item> _spawnItems(
    Location location,
    LocationConfig config,
    Position playerSpawn,
    Set<Position> usedPositions,
    Random random,
  ) {
    final items = <String, Item>{};

    if (config.itemPool.isEmpty) {
      return items;
    }

    final walkableTiles = location.map.walkableTiles;

    // Filter out tiles too close to player spawn and already used positions
    final validSpawns = walkableTiles.where((pos) {
      final posAsPosition = Position(x: pos.x, y: pos.y);

      // Not on player spawn
      if (pos.x == playerSpawn.x && pos.y == playerSpawn.y) return false;

      // Not on already used positions (monsters, stairs)
      if (usedPositions.contains(posAsPosition)) return false;

      // Not on stairs
      final tile = location.map.getTile(pos.x, pos.y);
      if (tile != null &&
          (tile.type == TileType.stairsUp || tile.type == TileType.stairsDown)) {
        return false;
      }

      return true;
    }).toList();

    if (validSpawns.isEmpty) {
      return items;
    }

    // Spawn 2-5 items per floor
    final itemCount = 2 + random.nextInt(4);
    final usedItemPositions = <Position>{};

    for (var i = 0; i < itemCount && validSpawns.isNotEmpty; i++) {
      // Pick a random spawn position
      final spawnIndex = random.nextInt(validSpawns.length);
      final spawn = validSpawns[spawnIndex];
      final spawnPosition = Position(x: spawn.x, y: spawn.y);

      // Skip if position already used for an item
      if (usedItemPositions.contains(spawnPosition)) continue;
      usedItemPositions.add(spawnPosition);

      // Pick a random item type from the pool
      final configId = config.itemPool[random.nextInt(config.itemPool.length)];
      final itemConfig = ItemRegistry.tryGet(configId);
      if (itemConfig == null) continue;

      // Create the item
      final item = Item.createInWorld(
        configId: configId,
        position: spawnPosition,
      );
      items[item.id] = item;
    }

    return items;
  }

  /// Sets up event listeners for game events.
  void _setupEventListeners() {
    // Listen for entity death events
    _subscriptions.add(
      eventBus.on<EntityDiedEvent>().listen((event) {
        if (event.entityId == gameState.player.id) {
          // Player died - trigger game over
          _gameState = gameState.copyWith(status: GameStatus.gameOver);
          overlays.add('gameOver');
          eventBus.fire(GameOverEvent(false));
        } else {
          // Monster died - award XP, drop loot, remove component
          _handleMonsterDeath(event.entityId);
        }
      }),
    );

    // Listen for entity moved events
    _subscriptions.add(
      eventBus.on<EntityMovedEvent>().listen((event) {
        // Update components will be handled in the game loop
      }),
    );

    // Listen for player entering tiles (stair detection)
    _subscriptions.add(
      eventBus.on<PlayerEnteredTileEvent>().listen((event) {
        _handlePlayerEnteredTile(event.position, event.tile);
      }),
    );
  }

  /// Handles the player entering a new tile (checks for stairs and portals).
  void _handlePlayerEnteredTile(Position position, Tile tile) {
    if (tile.type == TileType.stairsDown) {
      _descendFloor();
    } else if (tile.type == TileType.stairsUp) {
      _ascendFloor();
    }

    // Check for portal interaction
    _checkForPortalInteraction(position);
  }

  /// Checks if the player is standing on a portal and triggers traversal.
  void _checkForPortalInteraction(Position position) {
    final portal = gameState.worldObjects.values.firstWhereOrNull(
      (obj) => Portal.isPortal(obj) && obj.x == position.x && obj.y == position.y,
    );

    if (portal != null) {
      _traversePortal(Portal.getPortalId(portal));
    }
  }

  /// Traverses a portal to its destination location.
  void _traversePortal(String portalId) {
    final currentLocationId = gameState.currentLocation?.configId ?? '';
    final destination = PortalRegistry.getDestination(portalId, currentLocationId);
    if (destination == null) return;

    // Save current floor state
    _saveCurrentFloorState();

    // Get or generate destination location
    final destLocation = _getOrGenerateFloor(destination.locationId, destination.floor);

    // Find portal exit position at destination
    final exitPortal = _findPortalInLocation(destLocation, portalId);
    final spawnPos = exitPortal?.position ??
        Position(x: destLocation.map.width ~/ 2, y: destLocation.map.height ~/ 2);

    // Transition to the destination location
    _transitionToLocation(destLocation, destination.floor, spawnPos, destination.locationId);
  }

  /// Finds a portal in a location by portal ID.
  WorldObject? _findPortalInLocation(Location location, String portalId) {
    for (final objId in location.worldObjectIds) {
      final obj = gameState.worldObjects[objId];
      if (obj != null && Portal.isPortal(obj) && Portal.getPortalId(obj) == portalId) {
        return obj;
      }
    }
    return null;
  }

  /// Transitions to a different location (not just a floor change).
  void _transitionToLocation(Location location, int floor, Position spawnPos, String newConfigId) {
    final oldFloor = gameState.currentFloor;

    // Clear current components
    _clearFloorComponents();

    // Clear pathfinding cache for new location
    pathfindingService.clearCache();

    // Spawn monsters and items for new location if first visit
    Map<String, Monster> newMonsters;
    Map<String, Item> newItems;
    Map<String, WorldObject> newWorldObjects;

    if (!location.visited) {
      // First visit - spawn new content
      final config = LocationRegistry.get(newConfigId);
      newMonsters = _spawnMonsters(location, config, spawnPos, _random);

      final usedPositions = newMonsters.values.map((m) => m.position).toSet();
      newItems = _spawnItems(location, config, spawnPos, usedPositions, _random);

      // Create portals for this floor
      final portals = PortalPlacement.createPortals(location, newConfigId, floor, _random);
      newWorldObjects = Map<String, WorldObject>.from(gameState.worldObjects);
      final worldObjectIds = <String>[];
      for (final portal in portals) {
        newWorldObjects[portal.id] = portal;
        worldObjectIds.add(portal.id);
      }

      location = location.copyWith(
        visited: true,
        monsterIds: newMonsters.keys.toList(),
        itemIds: newItems.keys.toList(),
        worldObjectIds: worldObjectIds,
      );
    } else {
      // Returning to location - restore saved state
      newMonsters = {};
      for (final monsterId in location.monsterIds) {
        final monster = gameState.monsters[monsterId];
        if (monster != null && monster.isAlive) {
          newMonsters[monsterId] = monster;
        }
      }

      newItems = {};
      for (final itemId in location.itemIds) {
        final item = gameState.items[itemId];
        if (item != null && item.isInWorld) {
          newItems[itemId] = item;
        }
      }

      newWorldObjects = Map<String, WorldObject>.from(gameState.worldObjects);
    }

    // Update player position
    final newPlayer = gameState.player.moveTo(spawnPos);

    // Update locations map
    final newLocations = Map<String, Location>.from(gameState.locations)
      ..[location.id] = location;

    // Update game state
    _gameState = gameState.copyWith(
      player: newPlayer,
      currentLocationId: location.id,
      currentFloor: floor,
      locations: newLocations,
      monsters: newMonsters,
      items: newItems,
      worldObjects: newWorldObjects,
    );

    // Rebuild all floor components
    _createTileComponents();
    _createPlayerComponent();
    _createMonsterComponents();
    _createItemComponents();
    _createWorldObjectComponents();

    // Update camera bounds for new location
    _setupCamera();

    // Fire floor changed event
    eventBus.fire(FloorChangedEvent(newConfigId, oldFloor, floor));

    // Notify HUD of floor change
    onFloorChanged?.call(floor);

    // Auto-save on location change
    _autoSave();
  }

  /// Handles monster death: awards XP and drops loot.
  void _handleMonsterDeath(String monsterId) {
    final monster = gameState.monsters[monsterId];
    if (monster == null) {
      _removeMonsterComponent(monsterId);
      return;
    }

    final config = MonsterRegistry.tryGet(monster.configId);
    if (config == null) {
      _removeMonsterComponent(monsterId);
      return;
    }

    // Award XP to player
    var updatedPlayer = gameState.player.addExperience(config.xpValue);

    // Roll for loot drops
    final newItems = <String, Item>{};
    for (final lootEntry in config.lootTable) {
      if (_random.nextDouble() < lootEntry.chance) {
        final item = Item.createInWorld(
          configId: lootEntry.itemConfigId,
          position: monster.position,
        );
        newItems[item.id] = item;
      }
    }

    // Update game state with XP and dropped items
    final updatedItems = Map<String, Item>.from(gameState.items)..addAll(newItems);
    _gameState = gameState.copyWith(
      player: updatedPlayer,
      items: updatedItems,
    );

    // Create item components for dropped loot
    for (final item in newItems.values) {
      _addItemComponent(item);
    }

    // Remove monster component
    _removeMonsterComponent(monsterId);

    // Notify UI of state change
    onStateChanged?.call();
  }

  /// Descends to the next floor when stepping on stairs down.
  void _descendFloor() {
    final currentFloor = gameState.currentFloor;
    final nextFloor = currentFloor + 1;

    // Get location config to check max depth
    final location = gameState.currentLocation;
    if (location == null) return;

    final config = LocationRegistry.get(location.configId);
    if (nextFloor > config.maxDepth) {
      // Can't go deeper - at max depth
      return;
    }

    // Save current floor state before leaving
    _saveCurrentFloorState();

    // Get or generate the next floor
    final nextLocation = _getOrGenerateFloor(location.configId, nextFloor);

    // Find stairs up on the new floor (spawn point)
    final spawnPos = _findStairsUp(nextLocation);

    // Transition to the new floor
    _transitionToFloor(nextLocation, nextFloor, spawnPos);
  }

  /// Ascends to the previous floor when stepping on stairs up.
  void _ascendFloor() {
    final currentFloor = gameState.currentFloor;
    final prevFloor = currentFloor - 1;

    if (prevFloor < 0) {
      // Floor 0 stairs up = exit dungeon
      _exitDungeon();
      return;
    }

    // Save current floor state before leaving
    _saveCurrentFloorState();

    // Get the previous floor (must exist since we came from there)
    final location = gameState.currentLocation;
    if (location == null) return;

    final prevLocation = _getOrGenerateFloor(location.configId, prevFloor);

    // Find stairs down on the previous floor (where we came from)
    final spawnPos = _findStairsDown(prevLocation);

    // Transition to the previous floor
    _transitionToFloor(prevLocation, prevFloor, spawnPos);
  }

  /// Exits the dungeon (called when using stairs up on floor 0 or edge exit on surface).
  void _exitDungeon() {
    // If we have a world map callback, return to world map
    if (onExitToWorldMap != null) {
      onExitToWorldMap!();
      return;
    }
    // Otherwise treat exiting the dungeon as victory
    _gameState = gameState.copyWith(status: GameStatus.victory);
    overlays.add('gameOver');
    eventBus.fire(GameOverEvent(true));
  }

  /// Public method to exit to world map (called from PlayerComponent on edge exit).
  void exitToWorldMap() {
    _exitDungeon();
  }

  /// Gets an existing floor or generates a new one.
  Location _getOrGenerateFloor(String configId, int floor) {
    final locationId = Location.generateId(configId, floor);

    // Check if floor already exists in game state
    if (gameState.locations.containsKey(locationId)) {
      return gameState.locations[locationId]!;
    }

    // Generate new floor using the appropriate generator
    final config = LocationRegistry.get(configId);
    final generator = GeneratorRegistry.get(config.generatorType);
    final location = generator.generate(
      config: config,
      floor: floor,
      random: _random,
    );

    return location;
  }

  /// Finds the stairs up position on a floor.
  Position _findStairsUp(Location location) {
    final stairsUp = location.map.findTilesByType(TileType.stairsUp);
    if (stairsUp.isNotEmpty) {
      final stair = stairsUp.first;
      return Position(x: stair.x, y: stair.y);
    }
    // Fallback to first walkable tile
    return _findPlayerSpawn(location);
  }

  /// Finds the stairs down position on a floor.
  Position _findStairsDown(Location location) {
    final stairsDown = location.map.findTilesByType(TileType.stairsDown);
    if (stairsDown.isNotEmpty) {
      final stair = stairsDown.first;
      return Position(x: stair.x, y: stair.y);
    }
    // Fallback to first walkable tile
    return _findPlayerSpawn(location);
  }

  /// Saves the current floor state (monsters, items) before leaving.
  void _saveCurrentFloorState() {
    final location = gameState.currentLocation;
    if (location == null) return;

    // Get alive monsters on this floor
    final floorMonsterIds = gameState.monsters.entries
        .where((e) => e.value.isAlive)
        .map((e) => e.key)
        .toList();

    // Get items on this floor (not in player inventory)
    final floorItemIds = gameState.items.entries
        .where((e) => e.value.isInWorld)
        .map((e) => e.key)
        .toList();

    // Update location with current monster/item IDs
    final updatedLocation = location.copyWith(
      monsterIds: floorMonsterIds,
      itemIds: floorItemIds,
    );

    // Update game state with the updated location
    final newLocations = Map<String, Location>.from(gameState.locations)
      ..[location.id] = updatedLocation;

    _gameState = gameState.copyWith(locations: newLocations);
  }

  /// Transitions to a new floor within the same location.
  void _transitionToFloor(Location location, int floor, Position spawnPos) {
    final oldFloor = gameState.currentFloor;
    final configId = location.configId;

    // Clear current components
    _clearFloorComponents();

    // Clear pathfinding cache for new floor
    pathfindingService.clearCache();

    // Spawn monsters, items, and world objects for new floor if first visit
    Map<String, Monster> newMonsters;
    Map<String, Item> newItems;
    Map<String, WorldObject> newWorldObjects;
    
    if (!location.visited) {
      // First visit - spawn new monsters
      final config = LocationRegistry.get(configId);
      newMonsters = _spawnMonsters(location, config, spawnPos, _random);

      // Collect used positions (monsters)
      final usedPositions = newMonsters.values
          .map((m) => m.position)
          .toSet();

      // Spawn items
      newItems = _spawnItems(location, config, spawnPos, usedPositions, _random);

      // Create portals for this floor
      final portals = PortalPlacement.createPortals(location, configId, floor, _random);
      newWorldObjects = Map<String, WorldObject>.from(gameState.worldObjects);
      final worldObjectIds = <String>[];
      for (final portal in portals) {
        newWorldObjects[portal.id] = portal;
        worldObjectIds.add(portal.id);
      }

      // Mark location as visited and add monster/item/world object IDs
      location = location.copyWith(
        visited: true,
        monsterIds: newMonsters.keys.toList(),
        itemIds: newItems.keys.toList(),
        worldObjectIds: worldObjectIds,
      );
    } else {
      // Returning to floor - restore saved monsters
      newMonsters = {};
      for (final monsterId in location.monsterIds) {
        final monster = gameState.monsters[monsterId];
        if (monster != null && monster.isAlive) {
          newMonsters[monsterId] = monster;
        }
      }

      // Restore saved items
      newItems = {};
      for (final itemId in location.itemIds) {
        final item = gameState.items[itemId];
        if (item != null && item.isInWorld) {
          newItems[itemId] = item;
        }
      }

      // Keep existing world objects
      newWorldObjects = Map<String, WorldObject>.from(gameState.worldObjects);
    }

    // Update player position
    final newPlayer = gameState.player.moveTo(spawnPos);

    // Update locations map
    final newLocations = Map<String, Location>.from(gameState.locations)
      ..[location.id] = location;

    // Update game state
    _gameState = gameState.copyWith(
      player: newPlayer,
      currentLocationId: location.id,
      currentFloor: floor,
      locations: newLocations,
      monsters: newMonsters,
      items: newItems,
      worldObjects: newWorldObjects,
    );

    // Rebuild all floor components
    _createTileComponents();
    _createPlayerComponent();
    _createMonsterComponents();
    _createItemComponents();
    _createWorldObjectComponents();

    // Update camera bounds for new floor
    _setupCamera();

    // Fire floor changed event
    eventBus.fire(FloorChangedEvent(configId, oldFloor, floor));

    // Notify HUD of floor change
    onFloorChanged?.call(floor);

    // Auto-save on floor change
    _autoSave();
  }

  /// Auto-saves the game state.
  Future<void> _autoSave() async {
    try {
      await SaveService.instance.saveGame(gameState, 'autosave');
    } catch (e) {
      // Silently fail - save service may not be initialized
      debugPrint('Auto-save failed: $e');
    }
  }

  /// Saves the game to a slot.
  Future<void> saveGame([String slotId = 'autosave']) async {
    await SaveService.instance.saveGame(gameState, slotId);
  }

  /// Loads a game from a slot.
  /// Returns true if a save was loaded, false otherwise.
  Future<bool> loadGame([String slotId = 'autosave']) async {
    final loadedState = await SaveService.instance.loadGame(slotId);
    if (loadedState == null) return false;

    // Clear current components
    _clearFloorComponents();

    // Clear pathfinding cache
    pathfindingService.clearCache();

    // Set the loaded state
    _gameState = loadedState;

    // Rebuild all components
    _createTileComponents();
    _createPlayerComponent();
    _createMonsterComponents();
    _createItemComponents();
    _createWorldObjectComponents();

    // Update camera for loaded map
    _setupCamera();

    // Notify HUD of floor
    onFloorChanged?.call(gameState.currentFloor);

    return true;
  }

  /// Checks if a save exists.
  Future<bool> hasSave([String slotId = 'autosave']) async {
    return SaveService.instance.saveExists(slotId);
  }

  /// Clears all floor-specific components.
  void _clearFloorComponents() {
    // Remove all monster components
    for (final component in _monsterComponents.values) {
      world.remove(component);
    }
    _monsterComponents.clear();

    // Remove all item components
    for (final component in _itemComponents.values) {
      world.remove(component);
    }
    _itemComponents.clear();

    // Remove all world object components (portals, etc.)
    for (final component in _worldObjectComponents.values) {
      world.remove(component);
    }
    _worldObjectComponents.clear();

    // Remove player component
    if (_playerComponent != null) {
      world.remove(_playerComponent!);
      _playerComponent = null;
    }

    // Remove all tile components
    world.removeAll(world.children.whereType<TileComponent>());
  }

  /// Creates tile components for the map.
  void _createTileComponents() {
    final location = gameState.currentLocation;
    if (location == null) return;

    final map = location.map;
    for (var y = 0; y < map.height; y++) {
      for (var x = 0; x < map.width; x++) {
        final tile = map.getTile(x, y);
        if (tile != null) {
          world.add(TileComponent(
            tile: tile,
            gridX: x,
            gridY: y,
            tileSize: tileSize,
          ));
        }
      }
    }
  }

  /// Creates the player component.
  void _createPlayerComponent() {
    _playerComponent = PlayerComponent(
      player: gameState.player,
      tileSize: tileSize,
    );
    world.add(_playerComponent!);
  }

  /// Creates monster components for all monsters.
  void _createMonsterComponents() {
    for (final monster in gameState.monsters.values) {
      _addMonsterComponent(monster);
    }
  }

  /// Adds a monster component for a monster.
  void _addMonsterComponent(Monster monster) {
    final component = MonsterComponent(
      monster: monster,
      tileSize: tileSize,
    );
    _monsterComponents[monster.id] = component;
    world.add(component);
  }

  /// Removes a monster component.
  void _removeMonsterComponent(String monsterId) {
    final component = _monsterComponents.remove(monsterId);
    if (component != null) {
      world.remove(component);
    }
  }

  /// Creates item components for all items in the world.
  void _createItemComponents() {
    for (final item in gameState.items.values) {
      if (item.isInWorld) {
        _addItemComponent(item);
      }
    }
  }

  /// Adds an item component for an item.
  void _addItemComponent(Item item) {
    final component = ItemComponent(
      item: item,
      tileSize: tileSize,
    );
    _itemComponents[item.id] = component;
    world.add(component);
  }

  /// Removes an item component.
  void _removeItemComponent(String itemId) {
    final component = _itemComponents.remove(itemId);
    if (component != null) {
      world.remove(component);
    }
  }

  /// Creates world object components (portals, chests, etc.).
  void _createWorldObjectComponents() {
    final location = gameState.currentLocation;
    if (location == null) return;

    for (final objId in location.worldObjectIds) {
      final obj = gameState.worldObjects[objId];
      if (obj != null) {
        _addWorldObjectComponent(obj);
      }
    }
  }

  /// Adds a world object component.
  void _addWorldObjectComponent(WorldObject obj) {
    // Create a sprite component for the portal
    final component = SpriteComponent(
      sprite: Sprite(images.fromCache('icons/tiles/portal.png')),
      position: Vector2(obj.x * tileSize, obj.y * tileSize),
      size: Vector2.all(tileSize),
      priority: 5, // Above tiles, below entities
    );
    _worldObjectComponents[obj.id] = component;
    world.add(component);
  }

  // Note: _removeWorldObjectComponent intentionally defined for future use
  // (when world objects can be destroyed/removed during gameplay)

  /// Sets up the camera to follow the player.
  void _setupCamera() {
    final location = gameState.currentLocation;
    if (location == null) return;

    // Set viewfinder anchor to center (camera looks at center of viewport)
    camera.viewfinder.anchor = Anchor.center;

    // Follow the player component
    if (_playerComponent != null) {
      camera.follow(_playerComponent!);
      _isManualCameraControl = false;
      
      // Debug: Print player position
      debugPrint('Camera setup: Following player at ${_playerComponent!.position}');
    }

    // Set camera bounds (will be recalculated on resize if viewport not ready)
    _updateCameraBounds();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Handle snap-back to player after manual panning
    if (_isManualCameraControl) {
      _snapBackTimer -= dt;
      if (_snapBackTimer <= 0) {
        _resumeFollowingPlayer();
      }
    }
  }

  /// Resumes camera following the player.
  void _resumeFollowingPlayer() {
    if (_playerComponent != null) {
      camera.follow(_playerComponent!);
    }
    _isManualCameraControl = false;
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    // Stop following player and allow manual camera control
    if (!_isManualCameraControl) {
      camera.stop();
      _isManualCameraControl = true;
    }

    // Reset snap-back timer on each pan update
    _snapBackTimer = snapBackDelay;

    // Move camera by the inverse of the pan delta
    // (dragging right moves the view left, showing more of the right side)
    camera.moveBy(-info.delta.global);
  }

  @override
  void onPanEnd(DragEndInfo info) {
    // Keep the snap-back timer running when pan ends
    // Camera will snap back after delay
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    // Recalculate camera bounds when viewport size changes
    _updateCameraBounds();
  }

  /// Updates camera bounds based on current viewport size.
  void _updateCameraBounds() {
    // Don't update if game state not ready yet
    if (!isReady) return;

    final location = gameState.currentLocation;
    if (location == null) return;

    final worldWidth = location.map.width * tileSize;
    final worldHeight = location.map.height * tileSize;

    final viewportSize = camera.viewport.size;
    if (viewportSize.x <= 0 || viewportSize.y <= 0) return;

    final halfWidth = viewportSize.x / 2;
    final halfHeight = viewportSize.y / 2;

    final minX = min(halfWidth, worldWidth / 2);
    final minY = min(halfHeight, worldHeight / 2);
    final maxX = max(worldWidth - halfWidth, worldWidth / 2);
    final maxY = max(worldHeight - halfHeight, worldHeight / 2);

    camera.setBounds(
      Rectangle.fromLTRB(minX, minY, maxX, maxY),
    );
  }

  /// Processes a player action and updates the game state.
  void processPlayerAction(PlayerAction action) {
    // Process the action through the turn system
    _gameState = turnSystem.processPlayerAction(action, gameState);

    // Update components to match new state
    _syncComponents();

    // Snap camera back to player on any action
    if (_isManualCameraControl) {
      _resumeFollowingPlayer();
    }

    // Notify UI of state change
    onStateChanged?.call();

    // Check for game over
    if (gameState.status == GameStatus.gameOver) {
      overlays.add('gameOver');
      eventBus.fire(GameOverEvent(false));
    }
  }

  /// Synchronizes Flame components with the current game state.
  void _syncComponents() {
    // Update player component
    _playerComponent?.updatePlayer(gameState.player);

    // Update monster components
    for (final entry in gameState.monsters.entries) {
      final monsterId = entry.key;
      final monster = entry.value;

      if (_monsterComponents.containsKey(monsterId)) {
        if (monster.isAlive) {
          _monsterComponents[monsterId]!.updateMonster(monster);
        } else {
          _removeMonsterComponent(monsterId);
        }
      }
    }

    // Remove components for monsters that no longer exist
    final deadMonsterIds = _monsterComponents.keys
        .where((id) => !gameState.monsters.containsKey(id))
        .toList();
    for (final id in deadMonsterIds) {
      _removeMonsterComponent(id);
    }

    // Sync item components
    for (final entry in gameState.items.entries) {
      final itemId = entry.key;
      final item = entry.value;

      if (item.isInWorld) {
        // Item is in world - ensure component exists
        if (!_itemComponents.containsKey(itemId)) {
          _addItemComponent(item);
        } else {
          _itemComponents[itemId]!.updateItem(item);
        }
      } else {
        // Item is in inventory - remove component if exists
        if (_itemComponents.containsKey(itemId)) {
          _removeItemComponent(itemId);
        }
      }
    }

    // Remove components for items that no longer exist
    final removedItemIds = _itemComponents.keys
        .where((id) => !gameState.items.containsKey(id))
        .toList();
    for (final id in removedItemIds) {
      _removeItemComponent(id);
    }
  }

  /// Restarts the game with a fresh procedurally generated dungeon.
  void restart() {
    // Clear the autosave so we don't reload the old game
    SaveService.instance.deleteSave('autosave');

    // Clear all floor components
    _clearFloorComponents();

    // Clear pathfinding cache
    pathfindingService.clearCache();

    // Create new game state with fresh dungeon
    _gameState = _createGameState();

    // Recreate all components
    _createTileComponents();
    _createPlayerComponent();
    _createMonsterComponents();
    _createItemComponents();
    _createWorldObjectComponents();

    // Update camera for new map
    _setupCamera();

    // Remove game over overlay
    overlays.remove('gameOver');

    // Fire new game started event
    eventBus.fire(GameStartedEvent());

    // Notify HUD of floor reset
    onFloorChanged?.call(gameState.currentFloor);
  }

  @override
  void onRemove() {
    // Save game before removing
    if (isReady && gameState.status == GameStatus.playing) {
      _autoSave();
    }

    // Cancel all event subscriptions
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();

    super.onRemove();
  }
}
