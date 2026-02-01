import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../config/monster_config.dart';
import '../../models/entities/monster.dart';
import '../my_game.dart';

/// Component for rendering monsters in the game.
class MonsterComponent extends PositionComponent with HasGameReference<MyGame> {
  Monster _monster;
  final double tileSize;
  Sprite? _sprite;

  MonsterComponent({
    required Monster monster,
    required this.tileSize,
  })  : _monster = monster,
        super(
          position: Vector2(
            monster.position.x * tileSize,
            monster.position.y * tileSize,
          ),
          size: Vector2.all(tileSize),
          priority: 5, // Render above tiles but below player
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final config = MonsterRegistry.tryGet(_monster.configId);
    if (config != null) {
      final spritePath = 'icons/${config.spriteId}.png';
      try {
        final image = game.images.fromCache(spritePath);
        _sprite = Sprite(image);
      } catch (e) {
        // Fallback to null, will use colored diamond
      }
    }
  }

  /// Gets the monster's unique ID.
  String get monsterId => _monster.id;

  /// Gets the current monster data.
  Monster get monster => _monster;

  /// Updates the monster data and position.
  void updateMonster(Monster newMonster) {
    _monster = newMonster;
    position = Vector2(
      _monster.position.x * tileSize,
      _monster.position.y * tileSize,
    );
  }

  /// Gets the color for this monster type from its config.
  Color _getMonsterColor() {
    final config = MonsterRegistry.tryGet(_monster.configId);
    return config?.color ?? const Color(0xFFAA00AA); // default purple if no config
  }

  @override
  void render(Canvas canvas) {
    // Don't render dead monsters
    if (!_monster.isAlive) {
      return;
    }

    if (_sprite != null) {
      // Render monster sprite
      _sprite!.render(canvas, size: size);
    } else {
      // Fallback: Draw monster as a colored diamond/rhombus
      final paint = Paint()..color = _getMonsterColor();
      final center = Offset(size.x / 2, size.y / 2);
      final halfSize = size.x * 0.35;

      final path = Path()
        ..moveTo(center.dx, center.dy - halfSize) // top
        ..lineTo(center.dx + halfSize, center.dy) // right
        ..lineTo(center.dx, center.dy + halfSize) // bottom
        ..lineTo(center.dx - halfSize, center.dy) // left
        ..close();

      canvas.drawPath(path, paint);
    }

    // Draw health bar on top
    _renderHealthBar(canvas);
  }

  void _renderHealthBar(Canvas canvas) {
    final barWidth = size.x * 0.8;
    final barHeight = 4.0;
    final barX = (size.x - barWidth) / 2;
    final barY = -8.0;

    // Background (red)
    final bgPaint = Paint()..color = const Color(0xFFAA0000);
    canvas.drawRect(
      Rect.fromLTWH(barX, barY, barWidth, barHeight),
      bgPaint,
    );

    // Health (green)
    final healthPercent = _monster.healthPercent;
    final healthPaint = Paint()..color = const Color(0xFF00AA00);
    canvas.drawRect(
      Rect.fromLTWH(barX, barY, barWidth * healthPercent, barHeight),
      healthPaint,
    );
  }
}
