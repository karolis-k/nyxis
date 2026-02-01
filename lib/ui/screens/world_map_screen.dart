import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/location_config.dart';
import '../../models/entities/entity.dart';
import '../../models/world/world_map.dart';

/// A screen for displaying and navigating the world map.
class WorldMapScreen extends StatelessWidget {
  final WorldMap worldMap;
  final void Function(String locationId) onEnterLocation;
  final VoidCallback? onStateChanged;

  const WorldMapScreen({
    super.key,
    required this.worldMap,
    required this.onEnterLocation,
    this.onStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: WorldMapGame(
        worldMap: worldMap,
        onEnterLocation: onEnterLocation,
        onStateChanged: onStateChanged,
      ),
    );
  }
}

/// The Flame game that renders the world map.
class WorldMapGame extends FlameGame with KeyboardEvents {
  static const double tileSize = 48.0;

  WorldMap _worldMap;
  final void Function(String locationId) onEnterLocation;
  final VoidCallback? onStateChanged;

  WorldMapGame({
    required WorldMap worldMap,
    required this.onEnterLocation,
    this.onStateChanged,
  }) : _worldMap = worldMap;

  WorldMap get worldMap => _worldMap;

  void updateWorldMap(WorldMap newMap) {
    _worldMap = newMap;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Set up camera
    camera.viewfinder.anchor = Anchor.center;

    // Add tile components
    _createTileComponents();

    // Add player marker
    _createPlayerMarker();

    // Center camera on player
    _centerOnPlayer();
  }

  void _createTileComponents() {
    for (var y = 0; y < _worldMap.height; y++) {
      for (var x = 0; x < _worldMap.width; x++) {
        final tile = _worldMap.getTile(x, y);
        if (tile != null) {
          world.add(WorldMapTileComponent(
            tile: tile,
            gridX: x,
            gridY: y,
            tileSize: tileSize,
          ));
        }
      }
    }
  }

  void _createPlayerMarker() {
    world.add(PlayerMarkerComponent(
      position: _worldMap.playerPosition,
      tileSize: tileSize,
    ));
  }

  void _centerOnPlayer() {
    final playerPixelPos = Vector2(
      _worldMap.playerPosition.x * tileSize + tileSize / 2,
      _worldMap.playerPosition.y * tileSize + tileSize / 2,
    );
    camera.moveTo(playerPixelPos);
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }

    // Handle movement
    final direction = _getDirectionFromKey(event.logicalKey);
    if (direction != null) {
      _handleMovement(direction);
      return KeyEventResult.handled;
    }

    // Handle enter key to enter location
    if (event.logicalKey == LogicalKeyboardKey.enter ||
        event.logicalKey == LogicalKeyboardKey.space) {
      _handleEnterLocation();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  (int, int)? _getDirectionFromKey(LogicalKeyboardKey key) {
    return switch (key) {
      LogicalKeyboardKey.arrowUp || LogicalKeyboardKey.keyW => (0, -1),
      LogicalKeyboardKey.arrowDown || LogicalKeyboardKey.keyS => (0, 1),
      LogicalKeyboardKey.arrowLeft || LogicalKeyboardKey.keyA => (-1, 0),
      LogicalKeyboardKey.arrowRight || LogicalKeyboardKey.keyD => (1, 0),
      _ => null,
    };
  }

  void _handleMovement((int, int) direction) {
    final (dx, dy) = direction;
    final currentPos = _worldMap.playerPosition;
    final newX = currentPos.x + dx;
    final newY = currentPos.y + dy;

    if (_worldMap.isWalkable(newX, newY)) {
      _worldMap = _worldMap.copyWith(
        playerPosition: Position(x: newX, y: newY),
      );

      // Update player marker
      final marker =
          world.children.whereType<PlayerMarkerComponent>().firstOrNull;
      marker?.updatePosition(_worldMap.playerPosition);

      // Center camera
      _centerOnPlayer();

      onStateChanged?.call();
    }
  }

  void _handleEnterLocation() {
    final pos = _worldMap.playerPosition;
    final tile = _worldMap.getTile(pos.x, pos.y);
    if (tile != null && tile.hasLocation) {
      onEnterLocation(tile.locationId!);
    }
  }
}

/// Component for rendering a world map tile.
class WorldMapTileComponent extends PositionComponent {
  final MapTile tile;
  final int gridX;
  final int gridY;
  final double tileSize;

  WorldMapTileComponent({
    required this.tile,
    required this.gridX,
    required this.gridY,
    required this.tileSize,
  }) : super(
          position: Vector2(gridX * tileSize, gridY * tileSize),
          size: Vector2.all(tileSize),
        );

  Color _getTerrainColor() => switch (tile.terrain) {
        TerrainType.plains => const Color(0xFF88CC88),
        TerrainType.forest => const Color(0xFF228B22),
        TerrainType.mountain => const Color(0xFF808080),
        TerrainType.water => const Color(0xFF4444AA),
        TerrainType.desert => const Color(0xFFD2B48C),
        TerrainType.road => const Color(0xFFAA9966),
      };

  @override
  void render(Canvas canvas) {
    // Draw terrain
    final terrainPaint = Paint()..color = _getTerrainColor();
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), terrainPaint);

    // Draw border
    final borderPaint = Paint()
      ..color = Colors.black26
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), borderPaint);

    // Draw location icon if present
    if (tile.hasLocation) {
      final config = LocationRegistry.tryGet(tile.locationId!);
      final iconPaint = Paint()
        ..color =
            config != null ? _getLocationColor(config.type) : Colors.purple;

      // Draw a small icon in center
      final iconSize = tileSize * 0.4;
      final iconOffset = (tileSize - iconSize) / 2;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(iconOffset, iconOffset, iconSize, iconSize),
          const Radius.circular(4),
        ),
        iconPaint,
      );
    }
  }

  Color _getLocationColor(LocationType type) => switch (type) {
        LocationType.dungeon => Colors.red.shade700,
        LocationType.cave => Colors.brown.shade600,
        LocationType.surface => Colors.green.shade600,
        LocationType.town => Colors.blue.shade600,
      };
}

/// Component for rendering the player marker on the world map.
class PlayerMarkerComponent extends PositionComponent {
  final double tileSize;

  PlayerMarkerComponent({
    required Position position,
    required this.tileSize,
  }) : super(
          position: Vector2(position.x * tileSize, position.y * tileSize),
          size: Vector2.all(tileSize),
          priority: 10, // Render above tiles
        );

  void updatePosition(Position newPos) {
    position = Vector2(newPos.x * tileSize, newPos.y * tileSize);
  }

  @override
  void render(Canvas canvas) {
    final center = Offset(size.x / 2, size.y / 2);
    final radius = tileSize * 0.3;

    // Draw player marker
    final markerPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius, markerPaint);

    // Draw outline
    final outlinePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, outlinePaint);
  }
}
