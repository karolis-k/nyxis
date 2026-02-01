import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_config.freezed.dart';
part 'item_config.g.dart';

/// Types of items in the game.
@JsonEnum()
enum ItemType {
  /// Weapons deal damage to enemies
  weapon,

  /// Armor provides defense
  armor,

  /// Consumables are used once for an effect
  consumable,

  /// Keys unlock doors and chests
  key,

  /// Treasure items have gold value
  treasure,
}

/// Rarity tiers for items.
@JsonEnum()
enum ItemRarity {
  /// Common items, easily found
  common,

  /// Uncommon items, somewhat rare
  uncommon,

  /// Rare items, hard to find
  rare,

  /// Epic items, very powerful
  epic,

  /// Legendary items, extremely rare and powerful
  legendary,
}

/// Configuration for an item type.
///
/// This defines the static properties of an item type, not an instance.
/// Use this to look up item definitions when creating item instances.
@freezed
class ItemConfig with _$ItemConfig {
  const factory ItemConfig({
    /// Unique identifier (e.g., 'sword', 'health_potion')
    required String id,

    /// Display name shown to the player
    required String name,

    /// The type category of this item
    required ItemType type,

    /// Rarity tier of this item
    required ItemRarity rarity,

    /// Sprite identifier for rendering
    required String spriteId,

    /// Description shown in inventory/tooltips
    required String description,

    /// Base gold value for buying/selling
    @Default(0) int value,

    /// Whether this item can stack in inventory
    @Default(false) bool stackable,

    /// Type-specific properties (damage, healing, defense, etc.)
    @Default({}) Map<String, dynamic> properties,
  }) = _ItemConfig;

  const ItemConfig._();

  /// Creates an ItemConfig from JSON
  factory ItemConfig.fromJson(Map<String, dynamic> json) =>
      _$ItemConfigFromJson(json);

  /// Gets a property value with type casting
  T? getProperty<T>(String key) {
    final value = properties[key];
    if (value is T) return value;
    return null;
  }

  /// Gets damage for weapon items
  int get damage => getProperty<int>('damage') ?? 0;

  /// Gets defense for armor items
  int get defense => getProperty<int>('defense') ?? 0;

  /// Gets healing amount for consumables
  int get healing => getProperty<int>('healing') ?? 0;

  /// Gets mana restoration for consumables
  int get manaRestore => getProperty<int>('manaRestore') ?? 0;

  /// Gets attack speed modifier for weapons
  double get attackSpeed => getProperty<double>('attackSpeed') ?? 1.0;
}

/// Registry for all item configurations.
///
/// Use this to register and look up item definitions by ID or filter by type/rarity.
class ItemRegistry {
  ItemRegistry._();

  static final Map<String, ItemConfig> _items = {};
  static bool _initialized = false;

  /// Registers a single item configuration.
  static void register(ItemConfig config) {
    if (_items.containsKey(config.id)) {
      throw ArgumentError('Item with id "${config.id}" is already registered');
    }
    _items[config.id] = config;
  }

  /// Gets an item configuration by ID.
  ///
  /// Throws if the item is not found.
  static ItemConfig get(String id) {
    final config = _items[id];
    if (config == null) {
      throw ArgumentError('Item with id "$id" not found in registry');
    }
    return config;
  }

  /// Tries to get an item configuration by ID.
  ///
  /// Returns null if not found.
  static ItemConfig? tryGet(String id) {
    return _items[id];
  }

  /// Gets all registered item configurations.
  static List<ItemConfig> all() {
    return _items.values.toList();
  }

  /// Gets all items of a specific type.
  static List<ItemConfig> byType(ItemType type) {
    return _items.values.where((item) => item.type == type).toList();
  }

  /// Gets all items of a specific rarity.
  static List<ItemConfig> byRarity(ItemRarity rarity) {
    return _items.values.where((item) => item.rarity == rarity).toList();
  }

  /// Registers all default items.
  ///
  /// Should be called once at game startup.
  static void registerAll() {
    if (_initialized) return;
    _initialized = true;

    for (final item in _defaultItems) {
      register(item);
    }
  }

  /// Clears all registered items (useful for testing).
  static void clear() {
    _items.clear();
    _initialized = false;
  }
}

/// Default item configurations.
const List<ItemConfig> _defaultItems = [
  // Weapons
  ItemConfig(
    id: 'sword',
    name: 'Iron Sword',
    type: ItemType.weapon,
    rarity: ItemRarity.common,
    spriteId: 'sword',
    description: 'A sturdy iron sword. Reliable and effective.',
    value: 50,
    properties: {
      'damage': 10,
      'attackSpeed': 1.0,
    },
  ),
  ItemConfig(
    id: 'axe',
    name: 'Battle Axe',
    type: ItemType.weapon,
    rarity: ItemRarity.uncommon,
    spriteId: 'axe',
    description: 'A heavy battle axe. Slow but devastating.',
    value: 120,
    properties: {
      'damage': 18,
      'attackSpeed': 0.7,
    },
  ),
  ItemConfig(
    id: 'dagger',
    name: 'Steel Dagger',
    type: ItemType.weapon,
    rarity: ItemRarity.common,
    spriteId: 'dagger',
    description: 'A quick steel dagger. Fast but light damage.',
    value: 30,
    properties: {
      'damage': 6,
      'attackSpeed': 1.5,
    },
  ),

  // Armor
  ItemConfig(
    id: 'leather_armor',
    name: 'Leather Armor',
    type: ItemType.armor,
    rarity: ItemRarity.common,
    spriteId: 'armor',
    description: 'Basic leather armor. Provides light protection.',
    value: 40,
    properties: {
      'defense': 5,
    },
  ),
  ItemConfig(
    id: 'chainmail',
    name: 'Chainmail Armor',
    type: ItemType.armor,
    rarity: ItemRarity.uncommon,
    spriteId: 'chainmail',
    description: 'Interlocking metal rings. Solid protection.',
    value: 150,
    properties: {
      'defense': 12,
    },
  ),

  // Consumables
  ItemConfig(
    id: 'health_potion',
    name: 'Health Potion',
    type: ItemType.consumable,
    rarity: ItemRarity.common,
    spriteId: 'potion',
    description: 'Restores health when consumed.',
    value: 25,
    stackable: true,
    properties: {
      'healing': 30,
    },
  ),
  ItemConfig(
    id: 'mana_potion',
    name: 'Mana Potion',
    type: ItemType.consumable,
    rarity: ItemRarity.common,
    spriteId: 'potion',
    description: 'Restores mana when consumed.',
    value: 25,
    stackable: true,
    properties: {
      'manaRestore': 25,
    },
  ),

  // Keys
  ItemConfig(
    id: 'rusty_key',
    name: 'Rusty Key',
    type: ItemType.key,
    rarity: ItemRarity.common,
    spriteId: 'key',
    description: 'An old rusty key. Opens basic locks.',
    value: 10,
    properties: {
      'keyType': 'basic',
    },
  ),

  // Treasure
  ItemConfig(
    id: 'gold_coin',
    name: 'Gold Coin',
    type: ItemType.treasure,
    rarity: ItemRarity.common,
    spriteId: 'stone',
    description: 'A shiny gold coin.',
    value: 1,
    stackable: true,
  ),
  ItemConfig(
    id: 'gem',
    name: 'Precious Gem',
    type: ItemType.treasure,
    rarity: ItemRarity.rare,
    spriteId: 'gem',
    description: 'A brilliant gemstone of great value.',
    value: 100,
  ),
];
