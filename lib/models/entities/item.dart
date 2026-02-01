import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import 'entity.dart';

part 'item.freezed.dart';
part 'item.g.dart';

/// An item entity that can exist in the world or in an inventory.
@freezed
class Item with _$Item {
  const Item._();

  const factory Item({
    /// Unique identifier for this item instance.
    required String id,

    /// Reference to the item type in ItemRegistry.
    required String configId,

    /// Position on the game map, or null if in an inventory.
    Position? position,

    /// Stack quantity for stackable items.
    @Default(1) int quantity,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  /// Creates a new item instance in the world.
  factory Item.createInWorld({
    required String configId,
    required Position position,
    int quantity = 1,
  }) {
    return Item(
      id: const Uuid().v4(),
      configId: configId,
      position: position,
      quantity: quantity,
    );
  }

  /// Creates a new item instance for inventory (no world position).
  factory Item.createForInventory({
    required String configId,
    int quantity = 1,
  }) {
    return Item(
      id: const Uuid().v4(),
      configId: configId,
      position: null,
      quantity: quantity,
    );
  }
}

/// Extension methods for Item manipulation.
extension ItemExtensions on Item {
  /// X coordinate shorthand. Returns -1 if not in world.
  int get x => position?.x ?? -1;

  /// Y coordinate shorthand. Returns -1 if not in world.
  int get y => position?.y ?? -1;

  /// Returns true if this item is placed in the world (has a position).
  bool get isInWorld => position != null;

  /// Returns true if this item is in an inventory (no position).
  bool get isInInventory => position == null;

  /// Returns true if this item has more than one in the stack.
  bool get isStacked => quantity > 1;

  /// Returns a new item picked up from the world (position set to null).
  Item pickup() {
    return copyWith(position: null);
  }

  /// Returns a new item dropped at the specified position.
  Item dropAt(Position dropPosition) {
    return copyWith(position: dropPosition);
  }

  /// Returns a new item with quantity increased.
  Item addQuantity(int amount) {
    return copyWith(quantity: quantity + amount);
  }

  /// Returns a new item with quantity decreased.
  /// Quantity will not go below 0.
  Item removeQuantity(int amount) {
    return copyWith(quantity: (quantity - amount).clamp(0, quantity));
  }

  /// Splits the stack and returns a tuple of (remaining, split).
  /// If splitAmount >= quantity, returns (null, this).
  (Item? remaining, Item split) splitStack(int splitAmount) {
    if (splitAmount >= quantity) {
      return (null, this);
    }

    final remaining = copyWith(quantity: quantity - splitAmount);
    final split = Item(
      id: const Uuid().v4(),
      configId: configId,
      position: position,
      quantity: splitAmount,
    );

    return (remaining, split);
  }

  /// Attempts to merge another item into this stack.
  /// Returns the merged item if configIds match, otherwise returns this unchanged.
  Item? mergeWith(Item other) {
    if (configId != other.configId) {
      return null;
    }

    return copyWith(quantity: quantity + other.quantity);
  }
}
