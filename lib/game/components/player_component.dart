import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../config/location_config.dart';
import '../../models/entities/entity.dart';
import '../../models/entities/item.dart';
import '../../models/entities/monster.dart';
import '../../models/entities/player.dart';
import '../../core/event_bus.dart';
import '../../core/events.dart';
import '../systems/turn_system.dart';
import '../my_game.dart';

/// The player component that handles rendering and input for the player entity.
///
/// This component:
/// - Renders the player using a sprite (with fallback to colored circle)
/// - Handles keyboard input (WASD and arrow keys) for movement
/// - Coordinates with TurnSystem to process player actions
/// - Animates smoothly between grid positions using lerp
/// - Listens to game events for position updates and death detection
/// - Applies red tint effect when player is dead
class PlayerComponent extends PositionComponent with KeyboardHandler, HasGameReference<MyGame> {
  /// The current player entity data.
  Player _player;

  /// The size of each tile in pixels.
  final double tileSize;

  /// The radius of the player circle (slightly smaller than tile).
  double get playerRadius => tileSize * 0.4;

  /// Speed of the lerp animation (higher = faster).
  static const double lerpSpeed = 12.0;

  /// Target grid position that the player is moving towards.
  Vector2 _targetPosition = Vector2.zero();

  /// Current visual position used for smooth animation.
  Vector2 _visualPosition = Vector2.zero();

  /// Event subscriptions for cleanup.
  final List<StreamSubscription<GameEvent>> _subscriptions = [];

  /// The player sprite for rendering.
  Sprite? _sprite;

  /// Paint for rendering the player outline.
  final Paint _outlinePaint = Paint()
    ..color = Colors.green.shade900
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  /// Whether the player is dead.
  bool _isDead = false;

  /// Creates a new PlayerComponent.
  ///
  /// [player] is the initial player entity data.
  /// [tileSize] is the size of each tile in pixels.
  PlayerComponent({
    required Player player,
    required this.tileSize,
  }) : _player = player {
    // Set initial position immediately so camera.follow() works before onLoad
    final pixelPos = Vector2(
      player.position.x.toDouble() * tileSize,
      player.position.y.toDouble() * tileSize,
    );
    _targetPosition = pixelPos.clone();
    _visualPosition = pixelPos.clone();
    position = pixelPos;
    size = Vector2.all(tileSize);
  }

  /// Gets the current player entity.
  Player get player => _player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Set component size to tile size
    size = Vector2.all(tileSize);

    // Load the player sprite from the game's image cache
    final image = game.images.fromCache('icons/entities/human.png');
    _sprite = Sprite(image);

    // Initialize positions from player entity
    _updatePositionsFromPlayer();

    // Subscribe to game events
    _subscribeToEvents();
  }

  @override
  void onRemove() {
    // Cancel all event subscriptions
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
    super.onRemove();
  }

  /// Subscribes to relevant game events from the EventBus.
  void _subscribeToEvents() {
    // Listen for entity movement events
    _subscriptions.add(
      EventBus.instance.on<EntityMovedEvent>().listen(_onEntityMoved),
    );

    // Listen for entity death events
    _subscriptions.add(
      EventBus.instance.on<EntityDiedEvent>().listen(_onEntityDied),
    );
  }

  /// Handles EntityMovedEvent to update target position when player moves.
  void _onEntityMoved(EntityMovedEvent event) {
    // Check if this event is for the player
    if (event.entityId == _player.id) {
      _targetPosition = _gridToPixel(event.to);
    }
  }

  /// Handles EntityDiedEvent to detect player death.
  void _onEntityDied(EntityDiedEvent event) {
    if (event.entityId == _player.id) {
      _isDead = true;
      // Visual effects for death could be added here
    }
  }

  /// Updates the player entity and syncs positions.
  ///
  /// This is called by MyGame after processing actions.
  void updatePlayer(Player newPlayer) {
    final oldPosition = _player.position;
    _player = newPlayer;

    // If position changed, update target (in case event wasn't fired)
    if (oldPosition != newPlayer.position) {
      _targetPosition = _gridToPixel(newPlayer.position);
    }

    // Update death state
    _isDead = !newPlayer.isAlive;
  }

  /// Updates target and visual positions from the current player entity.
  void _updatePositionsFromPlayer() {
    final pixelPos = _gridToPixel(_player.position);
    _targetPosition = pixelPos.clone();
    _visualPosition = pixelPos.clone();
    position = _visualPosition;
  }

  /// Converts a grid position to pixel coordinates.
  Vector2 _gridToPixel(Position gridPos) {
    return Vector2(
      gridPos.x.toDouble() * tileSize,
      gridPos.y.toDouble() * tileSize,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Smoothly lerp visual position toward target position
    if (_visualPosition.distanceTo(_targetPosition) > 0.1) {
      _visualPosition.lerp(_targetPosition, lerpSpeed * dt);
    } else {
      // Snap to target when close enough
      _visualPosition.setFrom(_targetPosition);
    }

    // Update component position
    position = _visualPosition;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Calculate center of the tile for outline
    final center = Offset(tileSize / 2, tileSize / 2);

    if (_sprite != null) {
      // Render sprite with red tint if dead
      if (_isDead) {
        canvas.saveLayer(
          null,
          Paint()
            ..colorFilter = const ColorFilter.mode(
              Colors.red,
              BlendMode.modulate,
            ),
        );
        _sprite!.render(canvas, size: size);
        canvas.restore();
        _outlinePaint.color = Colors.red.shade900;
      } else {
        _sprite!.render(canvas, size: size);
        _outlinePaint.color = Colors.green.shade900;
      }

      // Draw outline for clarity
      canvas.drawCircle(center, playerRadius, _outlinePaint);
    } else {
      // Fallback to circle if sprite is null
      final fallbackPaint = Paint()
        ..color = _isDead ? Colors.red.shade300 : Colors.green
        ..style = PaintingStyle.fill;
      _outlinePaint.color =
          _isDead ? Colors.red.shade900 : Colors.green.shade900;

      canvas.drawCircle(center, playerRadius, fallbackPaint);
      canvas.drawCircle(center, playerRadius, _outlinePaint);
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // Only process key down events
    if (event is! KeyDownEvent) {
      return false;
    }

    // Check if player is dead
    if (_isDead) {
      return false;
    }

    // Check if game is still playing
    if (!game.gameState.isPlaying) {
      return false;
    }

    // Handle inventory key (I) - always available
    if (event.logicalKey == LogicalKeyboardKey.keyI) {
      game.overlays.add('inventory');
      return true;
    }

    // Handle pickup key (G) - pick up item at current position
    if (event.logicalKey == LogicalKeyboardKey.keyG) {
      _handlePickup();
      return true;
    }

    // Check if it's the player's turn for movement/attack
    if (!game.gameState.isPlayerTurn) {
      return false;
    }

    // Determine movement direction based on key
    final direction = _getDirectionFromKey(event.logicalKey);
    if (direction == null) {
      return false;
    }

    // Process the movement
    _handleMovement(direction);
    return true;
  }

  /// Handles picking up an item at the player's current position.
  void _handlePickup() {
    final gameState = game.gameState;
    final playerPos = _player.position;

    // Find items at player's position
    final itemsAtPosition = gameState.items.values
        .where((item) =>
            item.isInWorld &&
            item.position!.x == playerPos.x &&
            item.position!.y == playerPos.y)
        .toList();

    if (itemsAtPosition.isEmpty) {
      return; // No items to pick up
    }

    // Pick up the first item
    final itemToPickup = itemsAtPosition.first;
    game.processPlayerAction(PlayerPickupAction(itemToPickup.id));
  }

  /// Returns the direction offset for a given keyboard key.
  ///
  /// Returns null if the key is not a movement key.
  (int, int)? _getDirectionFromKey(LogicalKeyboardKey key) {
    return switch (key) {
      LogicalKeyboardKey.arrowUp || LogicalKeyboardKey.keyW => (0, -1),
      LogicalKeyboardKey.arrowDown || LogicalKeyboardKey.keyS => (0, 1),
      LogicalKeyboardKey.arrowLeft || LogicalKeyboardKey.keyA => (-1, 0),
      LogicalKeyboardKey.arrowRight || LogicalKeyboardKey.keyD => (1, 0),
      _ => null,
    };
  }

  /// Handles player movement in the specified direction.
  ///
  /// [direction] is a tuple of (dx, dy) representing the movement offset.
  void _handleMovement((int, int) direction) {
    final (dx, dy) = direction;
    final currentPos = _player.position;

    // Calculate target position
    final targetPos = Position(x: currentPos.x + dx, y: currentPos.y + dy);

    // Check for edge-based world map exit on surface locations
    final gameState = game.gameState;
    final location = gameState.currentLocation;
    if (location != null) {
      final config = LocationRegistry.tryGet(location.configId);
      if (config != null && config.isSurface && gameState.currentFloor == 0) {
        // Check if moving out of bounds
        final isOutOfBounds = targetPos.x < 0 ||
            targetPos.x >= location.map.width ||
            targetPos.y < 0 ||
            targetPos.y >= location.map.height;

        if (isOutOfBounds) {
          // On surface location floor 0 -> exit to world map
          game.exitToWorldMap();
          return;
        }
      }
    }

    // Check if there's a monster at the target position
    final monstersAtTarget = gameState.monstersAt(targetPos.x, targetPos.y);
    final targetMonster = monstersAtTarget.where((m) => m.isAlive).firstOrNull;

    // Create the appropriate action
    final PlayerAction action;
    if (targetMonster != null) {
      // Attack the monster
      action = PlayerAttackAction(targetMonster.id);
    } else {
      // Move to the target position
      action = PlayerMoveAction(targetPos);
    }

    // Process the action through the game
    game.processPlayerAction(action);
  }

  /// Syncs the component position with the current game state.
  ///
  /// Call this after loading a saved game or changing locations.
  void syncWithGameState() {
    _updatePositionsFromPlayer();
  }

  /// Returns true if the player is currently animating between positions.
  bool get isAnimating => _visualPosition.distanceTo(_targetPosition) > 0.1;
}
