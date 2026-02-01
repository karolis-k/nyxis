// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Tile _$TileFromJson(Map<String, dynamic> json) {
  return _Tile.fromJson(json);
}

/// @nodoc
mixin _$Tile {
  /// The base type of this tile.
  TileType get type => throw _privateConstructorUsedError;

  /// Whether entities can move through this tile.
  bool get walkable => throw _privateConstructorUsedError;

  /// Optional environmental feature on this tile.
  TileFeature? get feature => throw _privateConstructorUsedError;

  /// Optional runtime effect currently active on this tile.
  TileEffect? get effect => throw _privateConstructorUsedError;

  /// List of entity IDs currently on this tile.
  List<String> get contents => throw _privateConstructorUsedError;

  /// Whether this tile has been explored by the player.
  bool get explored => throw _privateConstructorUsedError;

  /// Whether this tile is currently visible to the player.
  bool get visible => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TileCopyWith<Tile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TileCopyWith<$Res> {
  factory $TileCopyWith(Tile value, $Res Function(Tile) then) =
      _$TileCopyWithImpl<$Res, Tile>;
  @useResult
  $Res call(
      {TileType type,
      bool walkable,
      TileFeature? feature,
      TileEffect? effect,
      List<String> contents,
      bool explored,
      bool visible});
}

/// @nodoc
class _$TileCopyWithImpl<$Res, $Val extends Tile>
    implements $TileCopyWith<$Res> {
  _$TileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? walkable = null,
    Object? feature = freezed,
    Object? effect = freezed,
    Object? contents = null,
    Object? explored = null,
    Object? visible = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TileType,
      walkable: null == walkable
          ? _value.walkable
          : walkable // ignore: cast_nullable_to_non_nullable
              as bool,
      feature: freezed == feature
          ? _value.feature
          : feature // ignore: cast_nullable_to_non_nullable
              as TileFeature?,
      effect: freezed == effect
          ? _value.effect
          : effect // ignore: cast_nullable_to_non_nullable
              as TileEffect?,
      contents: null == contents
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as List<String>,
      explored: null == explored
          ? _value.explored
          : explored // ignore: cast_nullable_to_non_nullable
              as bool,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TileImplCopyWith<$Res> implements $TileCopyWith<$Res> {
  factory _$$TileImplCopyWith(
          _$TileImpl value, $Res Function(_$TileImpl) then) =
      __$$TileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TileType type,
      bool walkable,
      TileFeature? feature,
      TileEffect? effect,
      List<String> contents,
      bool explored,
      bool visible});
}

/// @nodoc
class __$$TileImplCopyWithImpl<$Res>
    extends _$TileCopyWithImpl<$Res, _$TileImpl>
    implements _$$TileImplCopyWith<$Res> {
  __$$TileImplCopyWithImpl(_$TileImpl _value, $Res Function(_$TileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? walkable = null,
    Object? feature = freezed,
    Object? effect = freezed,
    Object? contents = null,
    Object? explored = null,
    Object? visible = null,
  }) {
    return _then(_$TileImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TileType,
      walkable: null == walkable
          ? _value.walkable
          : walkable // ignore: cast_nullable_to_non_nullable
              as bool,
      feature: freezed == feature
          ? _value.feature
          : feature // ignore: cast_nullable_to_non_nullable
              as TileFeature?,
      effect: freezed == effect
          ? _value.effect
          : effect // ignore: cast_nullable_to_non_nullable
              as TileEffect?,
      contents: null == contents
          ? _value._contents
          : contents // ignore: cast_nullable_to_non_nullable
              as List<String>,
      explored: null == explored
          ? _value.explored
          : explored // ignore: cast_nullable_to_non_nullable
              as bool,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TileImpl extends _Tile {
  const _$TileImpl(
      {required this.type,
      this.walkable = true,
      this.feature,
      this.effect,
      final List<String> contents = const [],
      this.explored = false,
      this.visible = false})
      : _contents = contents,
        super._();

  factory _$TileImpl.fromJson(Map<String, dynamic> json) =>
      _$$TileImplFromJson(json);

  /// The base type of this tile.
  @override
  final TileType type;

  /// Whether entities can move through this tile.
  @override
  @JsonKey()
  final bool walkable;

  /// Optional environmental feature on this tile.
  @override
  final TileFeature? feature;

  /// Optional runtime effect currently active on this tile.
  @override
  final TileEffect? effect;

  /// List of entity IDs currently on this tile.
  final List<String> _contents;

  /// List of entity IDs currently on this tile.
  @override
  @JsonKey()
  List<String> get contents {
    if (_contents is EqualUnmodifiableListView) return _contents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contents);
  }

  /// Whether this tile has been explored by the player.
  @override
  @JsonKey()
  final bool explored;

  /// Whether this tile is currently visible to the player.
  @override
  @JsonKey()
  final bool visible;

  @override
  String toString() {
    return 'Tile(type: $type, walkable: $walkable, feature: $feature, effect: $effect, contents: $contents, explored: $explored, visible: $visible)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.walkable, walkable) ||
                other.walkable == walkable) &&
            (identical(other.feature, feature) || other.feature == feature) &&
            (identical(other.effect, effect) || other.effect == effect) &&
            const DeepCollectionEquality().equals(other._contents, _contents) &&
            (identical(other.explored, explored) ||
                other.explored == explored) &&
            (identical(other.visible, visible) || other.visible == visible));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, walkable, feature, effect,
      const DeepCollectionEquality().hash(_contents), explored, visible);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TileImplCopyWith<_$TileImpl> get copyWith =>
      __$$TileImplCopyWithImpl<_$TileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TileImplToJson(
      this,
    );
  }
}

abstract class _Tile extends Tile {
  const factory _Tile(
      {required final TileType type,
      final bool walkable,
      final TileFeature? feature,
      final TileEffect? effect,
      final List<String> contents,
      final bool explored,
      final bool visible}) = _$TileImpl;
  const _Tile._() : super._();

  factory _Tile.fromJson(Map<String, dynamic> json) = _$TileImpl.fromJson;

  @override

  /// The base type of this tile.
  TileType get type;
  @override

  /// Whether entities can move through this tile.
  bool get walkable;
  @override

  /// Optional environmental feature on this tile.
  TileFeature? get feature;
  @override

  /// Optional runtime effect currently active on this tile.
  TileEffect? get effect;
  @override

  /// List of entity IDs currently on this tile.
  List<String> get contents;
  @override

  /// Whether this tile has been explored by the player.
  bool get explored;
  @override

  /// Whether this tile is currently visible to the player.
  bool get visible;
  @override
  @JsonKey(ignore: true)
  _$$TileImplCopyWith<_$TileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
