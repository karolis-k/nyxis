import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../models/world/tile.dart';
import '../my_game.dart';

/// Component for rendering tiles in the game world.
class TileComponent extends PositionComponent with HasGameReference<MyGame> {
  final Tile tile;
  final int gridX;
  final int gridY;
  final double tileSize;

  Sprite? _sprite;
  Sprite? _overlaySprite;

  TileComponent({
    required this.tile,
    required this.gridX,
    required this.gridY,
    required this.tileSize,
  }) : super(
          position: Vector2(gridX * tileSize, gridY * tileSize),
          size: Vector2.all(tileSize),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _loadSpritesForTileType(tile.type);
  }

  /// Loads sprites from the game's image cache based on tile type.
  void _loadSpritesForTileType(TileType type) {
    switch (type) {
      case TileType.floor:
        final image = game.images.fromCache('icons/tiles/stone-floor.png');
        _sprite = Sprite(image);
      case TileType.wall:
        final image = game.images.fromCache('icons/tiles/stone-wall.png');
        _sprite = Sprite(image);
      case TileType.stairsDown:
        final baseImage = game.images.fromCache('icons/tiles/stone-floor.png');
        final overlayImage = game.images.fromCache('icons/tiles/stair-down-overlay.png');
        _sprite = Sprite(baseImage);
        _overlaySprite = Sprite(overlayImage);
      case TileType.stairsUp:
        final baseImage = game.images.fromCache('icons/tiles/stone-floor.png');
        final overlayImage = game.images.fromCache('icons/tiles/stair-up-overlay.png');
        _sprite = Sprite(baseImage);
        _overlaySprite = Sprite(overlayImage);
      case TileType.water:
        final image = game.images.fromCache('icons/tiles/water.png');
        _sprite = Sprite(image);
      case TileType.lava:
        // Fallback to colored rect (no sprite yet)
        _sprite = null;
      case TileType.door:
        // Fallback to colored rect (no sprite yet)
        _sprite = null;
    }
  }

  /// Gets the color for a given tile type (exhaustive switch expression).
  /// Used as fallback when sprite is not available.
  Color _getColorForTileType(TileType type) => switch (type) {
    TileType.floor => const Color(0xFF333333), // dark gray
    TileType.wall => const Color(0xFF654321), // brown
    TileType.door => const Color(0xFFAAAA33), // yellow-ish
    TileType.stairsUp => const Color(0xFF3333AA), // light blue
    TileType.stairsDown => const Color(0xFF2222AA), // dark blue
    TileType.water => const Color(0xFF4444AA), // blue
    TileType.lava => const Color(0xFFAA3300), // orange-red
  };

  @override
  void render(Canvas canvas) {
    if (_sprite != null) {
      _sprite!.render(canvas, size: size);
      _overlaySprite?.render(canvas, size: size);
    } else {
      // Fallback to colored rectangle if sprite is null
      final paint = Paint()..color = _getColorForTileType(tile.type);
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.x, size.y),
        paint,
      );
    }
  }
}
