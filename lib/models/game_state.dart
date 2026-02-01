import 'package:freezed_annotation/freezed_annotation.dart';

import 'entities/player.dart';
import 'entities/monster.dart';
import 'entities/item.dart';
import 'entities/entity.dart';
import 'entities/world_object.dart';
import 'world/location.dart';
import 'world/world_map.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

/// Represents the current status of the game.
@JsonEnum()
enum GameStatus {
  /// Game is actively being played
  playing,

  /// Game is paused (menu open, etc.)
  paused,

  /// Player has died or otherwise lost
  gameOver,

  /// Player has achieved victory condition
  victory,
}

/// Central container holding all game data.
///
/// This is the single source of truth for the entire game state,
/// including player, monsters, items, locations, and turn management.
@freezed
class GameState with _$GameState {
  const factory GameState({
    /// The player entity
    required Player player,

    /// ID of the current location the player is in
    required String currentLocationId,

    /// Current dungeon floor (0 = surface/town, positive = dungeon depth)
    @Default(0) int currentFloor,

    /// All locations in the game world, keyed by locationId
    @Default({}) Map<String, Location> locations,

    /// All active monsters in the current location, keyed by monsterId
    @Default({}) Map<String, Monster> monsters,

    /// All items in the world (not in inventory), keyed by itemId
    @Default({}) Map<String, Item> items,

    /// All world objects (portals, chests, etc.), keyed by objectId
    @Default({}) Map<String, WorldObject> worldObjects,

    /// Current turn number (increments each time player takes an action)
    @Default(0) int turnNumber,

    /// Whether it's currently the player's turn to act
    @Default(true) bool isPlayerTurn,

    /// Current game status
    @Default(GameStatus.playing) GameStatus status,

    /// The world map for overworld navigation
    WorldMap? worldMap,

    /// Whether the player is currently on the world map (vs in a location)
    @Default(false) bool isOnWorldMap,
  }) = _GameState;

  const GameState._();

  /// Creates a GameState from JSON
  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);

  /// Gets the current location the player is in
  Location? get currentLocation => locations[currentLocationId];

  /// Gets the player's position on the world map
  Position? get worldMapPosition => worldMap?.playerPosition;

  /// Gets the current map tile the player is on
  MapTile? get currentWorldTile => worldMap?.getTile(
    worldMap!.playerPosition.x,
    worldMap!.playerPosition.y,
  );

  /// Whether the game is actively being played
  bool get isPlaying => status == GameStatus.playing;

  /// Whether the game has ended (either game over or victory)
  bool get isEnded => status == GameStatus.gameOver || status == GameStatus.victory;

  /// Gets all monsters that are still alive
  Map<String, Monster> get aliveMonsters =>
      Map.fromEntries(monsters.entries.where((e) => e.value.isAlive));

  /// Gets all monsters at a specific position
  Iterable<Monster> monstersAt(int x, int y) =>
      monsters.values.where((m) => m.x == x && m.y == y);

  /// Gets all items at a specific position
  Iterable<Item> itemsAt(int x, int y) =>
      items.values.where((i) => i.x == x && i.y == y);

  /// Checks if a tile is walkable (no walls, no monsters)
  bool isTileWalkable(int x, int y) {
    final location = currentLocation;
    if (location == null) return false;

    // Check if tile exists and is walkable
    if (!location.isTileWalkable(x, y)) return false;

    // Check if there's a monster blocking
    if (monstersAt(x, y).any((m) => m.isAlive && m.blocksMovement)) {
      return false;
    }

    return true;
  }
}
