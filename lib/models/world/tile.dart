import 'package:freezed_annotation/freezed_annotation.dart';

part 'tile.freezed.dart';
part 'tile.g.dart';

/// Types of tiles in the game world.
enum TileType {
  floor,
  wall,
  door,
  stairsUp,
  stairsDown,
  water,
  lava,
}

/// Optional environmental features that can appear on tiles.
enum TileFeature {
  water,
  deepWater,
  moss,
  grass,
  rubble,
  ice,
  lava,
  mud,
}

/// Runtime effects that can be applied to tiles (e.g., from spells or abilities).
enum TileEffect {
  burning,
  frozen,
  poisoned,
  electrified,
  blessed,
  cursed,
  darkness,
}

/// Represents a single tile in the game world map.
///
/// Tiles are immutable and contain information about:
/// - The base tile type (floor, wall, etc.)
/// - Whether entities can walk on this tile
/// - Optional environmental features
/// - Optional runtime effects
/// - IDs of entities currently occupying this tile
@freezed
class Tile with _$Tile {
  const factory Tile({
    /// The base type of this tile.
    required TileType type,

    /// Whether entities can move through this tile.
    @Default(true) bool walkable,

    /// Optional environmental feature on this tile.
    TileFeature? feature,

    /// Optional runtime effect currently active on this tile.
    TileEffect? effect,

    /// List of entity IDs currently on this tile.
    @Default([]) List<String> contents,

    /// Whether this tile has been explored by the player.
    @Default(false) bool explored,

    /// Whether this tile is currently visible to the player.
    @Default(false) bool visible,
  }) = _Tile;

  /// Private constructor for adding custom getters/methods.
  const Tile._();

  /// Creates a Tile from JSON.
  factory Tile.fromJson(Map<String, dynamic> json) => _$TileFromJson(json);

  /// Creates a basic floor tile.
  factory Tile.floor() => const Tile(type: TileType.floor, walkable: true);

  /// Creates a wall tile.
  factory Tile.wall() => const Tile(type: TileType.wall, walkable: false);

  /// Creates a door tile.
  factory Tile.door({bool walkable = true}) => Tile(
        type: TileType.door,
        walkable: walkable,
      );

  /// Creates stairs going up.
  factory Tile.stairsUp() => const Tile(type: TileType.stairsUp, walkable: true);

  /// Creates stairs going down.
  factory Tile.stairsDown() => const Tile(type: TileType.stairsDown, walkable: true);

  /// Creates a water tile.
  factory Tile.water({bool deep = false}) => Tile(
        type: TileType.water,
        walkable: !deep,
        feature: deep ? TileFeature.deepWater : TileFeature.water,
      );

  /// Creates a lava tile.
  factory Tile.lava() => const Tile(
        type: TileType.lava,
        walkable: false,
        feature: TileFeature.lava,
      );

  /// Whether this tile blocks line of sight.
  bool get blocksVision => type == TileType.wall;

  /// Alias for walkable property.
  bool get isWalkable => walkable;

  /// Alias for blocksVision getter.
  bool get isBlockingVision => blocksVision;

  /// Whether this tile has any entities on it.
  bool get hasContents => contents.isNotEmpty;

  /// Whether this tile is a transition point (stairs).
  bool get isTransition => type == TileType.stairsUp || type == TileType.stairsDown;

  /// Whether this tile is currently affected by an effect.
  bool get hasEffect => effect != null;

  /// Whether this tile has an environmental feature.
  bool get hasFeature => feature != null;

  /// Whether this tile is dangerous (lava, burning, poisoned, etc.).
  bool get isDangerous =>
      type == TileType.lava ||
      effect == TileEffect.burning ||
      effect == TileEffect.poisoned ||
      effect == TileEffect.electrified;
}
