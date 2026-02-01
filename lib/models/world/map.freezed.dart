// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameMap _$GameMapFromJson(Map<String, dynamic> json) {
  return _GameMap.fromJson(json);
}

/// @nodoc
mixin _$GameMap {
  /// Width of the map in tiles
  int get width => throw _privateConstructorUsedError;

  /// Height of the map in tiles
  int get height => throw _privateConstructorUsedError;

  /// 2D grid of tiles [y][x] - row-major order
  List<List<Tile>> get tiles => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameMapCopyWith<GameMap> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameMapCopyWith<$Res> {
  factory $GameMapCopyWith(GameMap value, $Res Function(GameMap) then) =
      _$GameMapCopyWithImpl<$Res, GameMap>;
  @useResult
  $Res call({int width, int height, List<List<Tile>> tiles});
}

/// @nodoc
class _$GameMapCopyWithImpl<$Res, $Val extends GameMap>
    implements $GameMapCopyWith<$Res> {
  _$GameMapCopyWithImpl(this._value, this._then);

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
              as List<List<Tile>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameMapImplCopyWith<$Res> implements $GameMapCopyWith<$Res> {
  factory _$$GameMapImplCopyWith(
          _$GameMapImpl value, $Res Function(_$GameMapImpl) then) =
      __$$GameMapImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int width, int height, List<List<Tile>> tiles});
}

/// @nodoc
class __$$GameMapImplCopyWithImpl<$Res>
    extends _$GameMapCopyWithImpl<$Res, _$GameMapImpl>
    implements _$$GameMapImplCopyWith<$Res> {
  __$$GameMapImplCopyWithImpl(
      _$GameMapImpl _value, $Res Function(_$GameMapImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? tiles = null,
  }) {
    return _then(_$GameMapImpl(
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
              as List<List<Tile>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameMapImpl extends _GameMap {
  const _$GameMapImpl(
      {required this.width,
      required this.height,
      required final List<List<Tile>> tiles})
      : _tiles = tiles,
        super._();

  factory _$GameMapImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameMapImplFromJson(json);

  /// Width of the map in tiles
  @override
  final int width;

  /// Height of the map in tiles
  @override
  final int height;

  /// 2D grid of tiles [y][x] - row-major order
  final List<List<Tile>> _tiles;

  /// 2D grid of tiles [y][x] - row-major order
  @override
  List<List<Tile>> get tiles {
    if (_tiles is EqualUnmodifiableListView) return _tiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tiles);
  }

  @override
  String toString() {
    return 'GameMap(width: $width, height: $height, tiles: $tiles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameMapImpl &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            const DeepCollectionEquality().equals(other._tiles, _tiles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, width, height, const DeepCollectionEquality().hash(_tiles));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameMapImplCopyWith<_$GameMapImpl> get copyWith =>
      __$$GameMapImplCopyWithImpl<_$GameMapImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameMapImplToJson(
      this,
    );
  }
}

abstract class _GameMap extends GameMap {
  const factory _GameMap(
      {required final int width,
      required final int height,
      required final List<List<Tile>> tiles}) = _$GameMapImpl;
  const _GameMap._() : super._();

  factory _GameMap.fromJson(Map<String, dynamic> json) = _$GameMapImpl.fromJson;

  @override

  /// Width of the map in tiles
  int get width;
  @override

  /// Height of the map in tiles
  int get height;
  @override

  /// 2D grid of tiles [y][x] - row-major order
  List<List<Tile>> get tiles;
  @override
  @JsonKey(ignore: true)
  _$$GameMapImplCopyWith<_$GameMapImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
