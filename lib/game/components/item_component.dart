import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../config/item_config.dart';
import '../../core/event_bus.dart';
import '../../core/events.dart';
import '../../models/entities/item.dart';
import '../my_game.dart';

/// Component for rendering items on the ground in the game world.
///
/// Items are rendered as sprites based on their type.
/// When picked up, the component removes itself from the game.
class ItemComponent extends PositionComponent with HasGameReference<MyGame> {
  /// The item entity data.
  Item _item;

  /// The size of each tile in pixels.
  final double tileSize;

  /// Event subscription for item pickup.
  StreamSubscription<ItemPickedUpEvent>? _pickupSubscription;

  /// The sprite for this item (loaded from image cache).
  Sprite? _sprite;

  /// Creates a new ItemComponent.
  ///
  /// [item] is the item entity data.
  /// [tileSize] is the size of each tile in pixels.
  ItemComponent({
    required Item item,
    required this.tileSize,
  })  : _item = item,
        super(
          position: Vector2(
            (item.position?.x ?? 0) * tileSize,
            (item.position?.y ?? 0) * tileSize,
          ),
          size: Vector2.all(tileSize),
          priority: 1, // Render above tiles but below entities
        );

  /// Gets the item's unique ID.
  String get itemId => _item.id;

  /// Gets the current item data.
  Item get item => _item;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load sprite from image cache based on item config
    final config = ItemRegistry.tryGet(_item.configId);
    if (config != null) {
      final spritePath = 'icons/items/${config.spriteId}.png';
      try {
        final image = game.images.fromCache(spritePath);
        _sprite = Sprite(image);
      } catch (e) {
        // Fallback to null, will use colored square
      }
    }

    // Subscribe to item pickup events
    _pickupSubscription = EventBus.instance.on<ItemPickedUpEvent>().listen(
      (event) {
        if (event.itemId == _item.id) {
          // Item was picked up, remove from game
          removeFromParent();
        }
      },
    );
  }

  @override
  void onRemove() {
    _pickupSubscription?.cancel();
    _pickupSubscription = null;
    super.onRemove();
  }

  /// Gets the color for this item based on its type (exhaustive switch expression).
  Color _getItemColor() {
    final config = ItemRegistry.tryGet(_item.configId);
    if (config == null) {
      return const Color(0xFFFFFF00); // Default yellow
    }

    return switch (config.type) {
      ItemType.weapon => const Color(0xFFCCCCCC), // Silver
      ItemType.armor => const Color(0xFF8888AA), // Blue-gray
      ItemType.consumable => const Color(0xFFFF6666), // Light red (potion)
      ItemType.key => const Color(0xFFFFD700), // Gold
      ItemType.treasure => const Color(0xFFFFFF00), // Yellow
    };
  }

  /// Gets an additional accent color based on rarity (exhaustive switch expression).
  Color _getRarityColor() {
    final config = ItemRegistry.tryGet(_item.configId);
    if (config == null) {
      return const Color(0xFFFFFFFF);
    }

    return switch (config.rarity) {
      ItemRarity.common => const Color(0xFFAAAAAA), // Gray
      ItemRarity.uncommon => const Color(0xFF00FF00), // Green
      ItemRarity.rare => const Color(0xFF0066FF), // Blue
      ItemRarity.epic => const Color(0xFFAA00FF), // Purple
      ItemRarity.legendary => const Color(0xFFFFAA00), // Orange
    };
  }

  @override
  void render(Canvas canvas) {
    // Don't render if item has no position (in inventory)
    if (_item.position == null) {
      return;
    }

    final rarityColor = _getRarityColor();

    // Calculate item size (~70% of tile, items should be smaller than entities)
    final itemSize = tileSize * 0.7;
    final offset = (tileSize - itemSize) / 2;

    if (_sprite != null) {
      // Render sprite
      _sprite!.render(
        canvas,
        position: Vector2(offset, offset),
        size: Vector2.all(itemSize),
      );
    } else {
      // Fallback: Draw item as a small colored square with rounded corners
      final itemColor = _getItemColor();
      final fallbackSize = tileSize * 0.4;
      final fallbackOffset = (tileSize - fallbackSize) / 2;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(fallbackOffset, fallbackOffset, fallbackSize, fallbackSize),
        const Radius.circular(4),
      );

      final fillPaint = Paint()..color = itemColor;
      canvas.drawRRect(rect, fillPaint);
    }

    // Draw rarity border on top
    final borderRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(offset, offset, itemSize, itemSize),
      const Radius.circular(4),
    );
    final borderPaint = Paint()
      ..color = rarityColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRRect(borderRect, borderPaint);
  }

  /// Updates the item data.
  void updateItem(Item newItem) {
    _item = newItem;
    if (_item.position != null) {
      position = Vector2(
        _item.position!.x * tileSize,
        _item.position!.y * tileSize,
      );
    }
  }
}
