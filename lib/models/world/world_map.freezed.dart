// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'world_map.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MapTile _$MapTileFromJson(Map<String, dynamic> json) {
  return _MapTile.fromJson(json);
}

/// @nodoc
mixin _$MapTile {
  TerrainType get terrain => throw _privateConstructorUsedError;

  /// Reference to LocationConfig.id
  String? get locationId => throw _privateConstructorUsedError;
  bool get discovered => throw _privateConstructorUsedError;
  bool get visited => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MapTileCopyWith<MapTile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapTileCopyWith<$Res> {
  factory $MapTileCopyWith(MapTile value, $Res Function(MapTile) then) =
      _$MapTileCopyWithImpl<$Res, MapTile>;
  @useResult
  $Res call(
      {TerrainType terrain, String? locationId, bool discovered, bool visited});
}

/// @nodoc
class _$MapTileCopyWithImpl<$Res, $Val extends MapTile>
    implements $MapTileCopyWith<$Res> {
  _$MapTileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? terrain = null,
    Object? locationId = freezed,
    Object? discovered = null,
    Object? visited = null,
  }) {
    return _then(_value.copyWith(
      terrain: null == terrain
          ? _value.terrain
          : terrain // ignore: cast_nullable_to_non_nullable
              as TerrainType,
      locationId: freezed == locationId
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as String?,
      discovered: null == discovered
          ? _value.discovered
          : discovered // ignore: cast_nullable_to_non_nullable
              as bool,
      visited: null == visited
          ? _value.visited
          : visited // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MapTileImplCopyWith<$Res> implements $MapTileCopyWith<$Res> {
  factory _$$MapTileImplCopyWith(
          _$MapTileImpl value, $Res Function(_$MapTileImpl) then) =
      __$$MapTileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TerrainType terrain, String? locationId, bool discovered, bool visited});
}

/// @nodoc
class __$$MapTileImplCopyWithImpl<$Res>
    extends _$MapTileCopyWithImpl<$Res, _$MapTileImpl>
    implements _$$MapTileImplCopyWith<$Res> {
  __$$MapTileImplCopyWithImpl(
      _$MapTileImpl _value, $Res Function(_$MapTileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? terrain = null,
    Object? locationId = freezed,
    Object? discovered = null,
    Object? visited = null,
  }) {
    return _then(_$MapTileImpl(
      terrain: null == terrain
          ? _value.terrain
          : terrain // ignore: cast_nullable_to_non_nullable
              as TerrainType,
      locationId: freezed == locationId
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as String?,
      discovered: null == discovered
          ? _value.discovered
          : discovered // ignore: cast_nullable_to_non_nullable
              as bool,
      visited: null == visited
          ? _value.visited
          : visited // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MapTileImpl extends _MapTile {
  const _$MapTileImpl(
      {required this.terrain,
      this.locationId,
      this.discovered = false,
      this.visited = false})
      : super._();

  factory _$MapTileImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapTileImplFromJson(json);

  @override
  final TerrainType terrain;

  /// Reference to LocationConfig.id
  @override
  final String? locationId;
  @override
  @JsonKey()
  final bool discovered;
  @override
  @JsonKey()
  final bool visited;

  @override
  String toString() {
    return 'MapTile(terrain: $terrain, locationId: $locationId, discovered: $discovered, visited: $visited)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapTileImpl &&
            (identical(other.terrain, terrain) || other.terrain == terrain) &&
            (identical(other.locationId, locationId) ||
                other.locationId == locationId) &&
            (identical(other.discovered, discovered) ||
                other.discovered == discovered) &&
            (identical(other.visited, visited) || other.visited == visited));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, terrain, locationId, discovered, visited);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MapTileImplCopyWith<_$MapTileImpl> get copyWith =>
      __$$MapTileImplCopyWithImpl<_$MapTileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapTileImplToJson(
      this,
    );
  }
}

abstract class _MapTile extends MapTile {
  const factory _MapTile(
      {required final TerrainType terrain,
      final String? locationId,
      final bool discovered,
      final bool visited}) = _$MapTileImpl;
  const _MapTile._() : super._();

  factory _MapTile.fromJson(Map<String, dynamic> json) = _$MapTileImpl.fromJson;

  @override
  TerrainType get terrain;
  @override

  /// Reference to LocationConfig.id
  String? get locationId;
  @override
  bool get discovered;
  @override
  bool get visited;
  @override
  @JsonKey(ignore: true)
  _$$MapTileImplCopyWith<_$MapTileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorldMap _$WorldMapFromJson(Map<String, dynamic> json) {
  return _WorldMap.fromJson(json);
}

/// @nodoc
mixin _$WorldMap {
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  List<List<MapTile>> get tiles => throw _privateConstructorUsedError;
  Position get playerPosition => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorldMapCopyWith<WorldMap> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorldMapCopyWith<$Res> {
  factory $WorldMapCopyWith(WorldMap value, $Res Function(WorldMap) then) =
      _$WorldMapCopyWithImpl<$Res, WorldMap>;
  @useResult
  $Res call(
      {int width,
      int height,
      List<List<MapTile>> tiles,
      Position playerPosition});

  $PositionCopyWith<$Res> get playerPosition;
}

/// @nodoc
class _$WorldMapCopyWithImpl<$Res, $Val extends WorldMap>
    implements $WorldMapCopyWith<$Res> {
  _$WorldMapCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? tiles = null,
    Object? playerPosition = null,
  }) {
    return _then(_value.copyWith(
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      tiles: null == tiles
          ? _value.tiles
          : tiles // ignore: cast_nullable_to_non_nullable
              as List<List<MapTile>>,
      playerPosition: null == playerPosition
          ? _value.playerPosition
          : playerPosition // ignore: cast_nullable_to_non_nullable
              as Position,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PositionCopyWith<$Res> get playerPosition {
    return $PositionCopyWith<$Res>(_value.playerPosition, (value) {
      return _then(_value.copyWith(playerPosition: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorldMapImplCopyWith<$Res>
    implements $WorldMapCopyWith<$Res> {
  factory _$$WorldMapImplCopyWith(
          _$WorldMapImpl value, $Res Function(_$WorldMapImpl) then) =
      __$$WorldMapImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int width,
      int height,
      List<List<MapTile>> tiles,
      Position playerPosition});

  @override
  $PositionCopyWith<$Res> get playerPosition;
}

/// @nodoc
class __$$WorldMapImplCopyWithImpl<$Res>
    extends _$WorldMapCopyWithImpl<$Res, _$WorldMapImpl>
    implements _$$WorldMapImplCopyWith<$Res> {
  __$$WorldMapImplCopyWithImpl(
      _$WorldMapImpl _value, $Res Function(_$WorldMapImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? tiles = null,
    Object? playerPosition = null,
  }) {
    return _then(_$WorldMapImpl(
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      tiles: null == tiles
          ? _value._tiles
          : tiles // ignore: cast_nullable_to_non_nullable
              as List<List<MapTile>>,
      playerPosition: null == playerPosition
          ? _value.playerPosition
          : playerPosition // ignore: cast_nullable_to_non_nullable
              as Position,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorldMapImpl extends _WorldMap {
  const _$WorldMapImpl(
      {required this.width,
      required this.height,
      required final List<List<MapTile>> tiles,
      this.playerPosition = const Position(x: 5, y: 5)})
      : _tiles = tiles,
        super._();

  factory _$WorldMapImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorldMapImplFromJson(json);

  @override
  final int width;
  @override
  final int height;
  final List<List<MapTile>> _tiles;
  @override
  List<List<MapTile>> get tiles {
    if (_tiles is EqualUnmodifiableListView) return _tiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tiles);
  }

  @override
  @JsonKey()
  final Position playerPosition;

  @override
  String toString() {
    return 'WorldMap(width: $width, height: $height, tiles: $tiles, playerPosition: $playerPosition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorldMapImpl &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            const DeepCollectionEquality().equals(other._tiles, _tiles) &&
            (identical(other.playerPosition, playerPosition) ||
                other.playerPosition == playerPosition));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, width, height,
      const DeepCollectionEquality().hash(_tiles), playerPosition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorldMapImplCopyWith<_$WorldMapImpl> get copyWith =>
      __$$WorldMapImplCopyWithImpl<_$WorldMapImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorldMapImplToJson(
      this,
    );
  }
}

abstract class _WorldMap extends WorldMap {
  const factory _WorldMap(
      {required final int width,
      required final int height,
      required final List<List<MapTile>> tiles,
      final Position playerPosition}) = _$WorldMapImpl;
  const _WorldMap._() : super._();

  factory _WorldMap.fromJson(Map<String, dynamic> json) =
      _$WorldMapImpl.fromJson;

  @override
  int get width;
  @override
  int get height;
  @override
  List<List<MapTile>> get tiles;
  @override
  Position get playerPosition;
  @override
  @JsonKey(ignore: true)
  _$$WorldMapImplCopyWith<_$WorldMapImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
