// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LocationConfig _$LocationConfigFromJson(Map<String, dynamic> json) {
  return _LocationConfig.fromJson(json);
}

/// @nodoc
mixin _$LocationConfig {
  /// Unique identifier for this location config (e.g., 'dark_dungeon', 'goblin_cave').
  String get id => throw _privateConstructorUsedError;

  /// Display name shown to the player.
  String get name => throw _privateConstructorUsedError;

  /// The type of location (dungeon, cave, surface, town).
  LocationType get type => throw _privateConstructorUsedError;

  /// Whether this is an outdoor/surface location.
  /// True for outdoor areas, false for underground.
  bool get isSurface => throw _privateConstructorUsedError;

  /// Maximum number of floors in this location.
  /// 1 for surface locations, higher for dungeons/caves.
  int get maxDepth => throw _privateConstructorUsedError;

  /// The generator ID used to create this location's map.
  /// Maps to a specific map generation algorithm (e.g., 'dungeon', 'cave', 'surface').
  String get generatorType => throw _privateConstructorUsedError;

  /// Optional ambient music track ID for this location.
  String? get ambientMusic => throw _privateConstructorUsedError;

  /// List of monster config IDs that can spawn in this location.
  List<String> get monsterPool => throw _privateConstructorUsedError;

  /// List of item config IDs that can spawn in this location.
  List<String> get itemPool => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationConfigCopyWith<LocationConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationConfigCopyWith<$Res> {
  factory $LocationConfigCopyWith(
          LocationConfig value, $Res Function(LocationConfig) then) =
      _$LocationConfigCopyWithImpl<$Res, LocationConfig>;
  @useResult
  $Res call(
      {String id,
      String name,
      LocationType type,
      bool isSurface,
      int maxDepth,
      String generatorType,
      String? ambientMusic,
      List<String> monsterPool,
      List<String> itemPool});
}

/// @nodoc
class _$LocationConfigCopyWithImpl<$Res, $Val extends LocationConfig>
    implements $LocationConfigCopyWith<$Res> {
  _$LocationConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? isSurface = null,
    Object? maxDepth = null,
    Object? generatorType = null,
    Object? ambientMusic = freezed,
    Object? monsterPool = null,
    Object? itemPool = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LocationType,
      isSurface: null == isSurface
          ? _value.isSurface
          : isSurface // ignore: cast_nullable_to_non_nullable
              as bool,
      maxDepth: null == maxDepth
          ? _value.maxDepth
          : maxDepth // ignore: cast_nullable_to_non_nullable
              as int,
      generatorType: null == generatorType
          ? _value.generatorType
          : generatorType // ignore: cast_nullable_to_non_nullable
              as String,
      ambientMusic: freezed == ambientMusic
          ? _value.ambientMusic
          : ambientMusic // ignore: cast_nullable_to_non_nullable
              as String?,
      monsterPool: null == monsterPool
          ? _value.monsterPool
          : monsterPool // ignore: cast_nullable_to_non_nullable
              as List<String>,
      itemPool: null == itemPool
          ? _value.itemPool
          : itemPool // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationConfigImplCopyWith<$Res>
    implements $LocationConfigCopyWith<$Res> {
  factory _$$LocationConfigImplCopyWith(_$LocationConfigImpl value,
          $Res Function(_$LocationConfigImpl) then) =
      __$$LocationConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      LocationType type,
      bool isSurface,
      int maxDepth,
      String generatorType,
      String? ambientMusic,
      List<String> monsterPool,
      List<String> itemPool});
}

/// @nodoc
class __$$LocationConfigImplCopyWithImpl<$Res>
    extends _$LocationConfigCopyWithImpl<$Res, _$LocationConfigImpl>
    implements _$$LocationConfigImplCopyWith<$Res> {
  __$$LocationConfigImplCopyWithImpl(
      _$LocationConfigImpl _value, $Res Function(_$LocationConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? isSurface = null,
    Object? maxDepth = null,
    Object? generatorType = null,
    Object? ambientMusic = freezed,
    Object? monsterPool = null,
    Object? itemPool = null,
  }) {
    return _then(_$LocationConfigImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LocationType,
      isSurface: null == isSurface
          ? _value.isSurface
          : isSurface // ignore: cast_nullable_to_non_nullable
              as bool,
      maxDepth: null == maxDepth
          ? _value.maxDepth
          : maxDepth // ignore: cast_nullable_to_non_nullable
              as int,
      generatorType: null == generatorType
          ? _value.generatorType
          : generatorType // ignore: cast_nullable_to_non_nullable
              as String,
      ambientMusic: freezed == ambientMusic
          ? _value.ambientMusic
          : ambientMusic // ignore: cast_nullable_to_non_nullable
              as String?,
      monsterPool: null == monsterPool
          ? _value._monsterPool
          : monsterPool // ignore: cast_nullable_to_non_nullable
              as List<String>,
      itemPool: null == itemPool
          ? _value._itemPool
          : itemPool // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationConfigImpl extends _LocationConfig {
  const _$LocationConfigImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.isSurface,
      required this.maxDepth,
      required this.generatorType,
      this.ambientMusic,
      final List<String> monsterPool = const [],
      final List<String> itemPool = const []})
      : _monsterPool = monsterPool,
        _itemPool = itemPool,
        super._();

  factory _$LocationConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationConfigImplFromJson(json);

  /// Unique identifier for this location config (e.g., 'dark_dungeon', 'goblin_cave').
  @override
  final String id;

  /// Display name shown to the player.
  @override
  final String name;

  /// The type of location (dungeon, cave, surface, town).
  @override
  final LocationType type;

  /// Whether this is an outdoor/surface location.
  /// True for outdoor areas, false for underground.
  @override
  final bool isSurface;

  /// Maximum number of floors in this location.
  /// 1 for surface locations, higher for dungeons/caves.
  @override
  final int maxDepth;

  /// The generator ID used to create this location's map.
  /// Maps to a specific map generation algorithm (e.g., 'dungeon', 'cave', 'surface').
  @override
  final String generatorType;

  /// Optional ambient music track ID for this location.
  @override
  final String? ambientMusic;

  /// List of monster config IDs that can spawn in this location.
  final List<String> _monsterPool;

  /// List of monster config IDs that can spawn in this location.
  @override
  @JsonKey()
  List<String> get monsterPool {
    if (_monsterPool is EqualUnmodifiableListView) return _monsterPool;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monsterPool);
  }

  /// List of item config IDs that can spawn in this location.
  final List<String> _itemPool;

  /// List of item config IDs that can spawn in this location.
  @override
  @JsonKey()
  List<String> get itemPool {
    if (_itemPool is EqualUnmodifiableListView) return _itemPool;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemPool);
  }

  @override
  String toString() {
    return 'LocationConfig(id: $id, name: $name, type: $type, isSurface: $isSurface, maxDepth: $maxDepth, generatorType: $generatorType, ambientMusic: $ambientMusic, monsterPool: $monsterPool, itemPool: $itemPool)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isSurface, isSurface) ||
                other.isSurface == isSurface) &&
            (identical(other.maxDepth, maxDepth) ||
                other.maxDepth == maxDepth) &&
            (identical(other.generatorType, generatorType) ||
                other.generatorType == generatorType) &&
            (identical(other.ambientMusic, ambientMusic) ||
                other.ambientMusic == ambientMusic) &&
            const DeepCollectionEquality()
                .equals(other._monsterPool, _monsterPool) &&
            const DeepCollectionEquality().equals(other._itemPool, _itemPool));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      isSurface,
      maxDepth,
      generatorType,
      ambientMusic,
      const DeepCollectionEquality().hash(_monsterPool),
      const DeepCollectionEquality().hash(_itemPool));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationConfigImplCopyWith<_$LocationConfigImpl> get copyWith =>
      __$$LocationConfigImplCopyWithImpl<_$LocationConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationConfigImplToJson(
      this,
    );
  }
}

abstract class _LocationConfig extends LocationConfig {
  const factory _LocationConfig(
      {required final String id,
      required final String name,
      required final LocationType type,
      required final bool isSurface,
      required final int maxDepth,
      required final String generatorType,
      final String? ambientMusic,
      final List<String> monsterPool,
      final List<String> itemPool}) = _$LocationConfigImpl;
  const _LocationConfig._() : super._();

  factory _LocationConfig.fromJson(Map<String, dynamic> json) =
      _$LocationConfigImpl.fromJson;

  @override

  /// Unique identifier for this location config (e.g., 'dark_dungeon', 'goblin_cave').
  String get id;
  @override

  /// Display name shown to the player.
  String get name;
  @override

  /// The type of location (dungeon, cave, surface, town).
  LocationType get type;
  @override

  /// Whether this is an outdoor/surface location.
  /// True for outdoor areas, false for underground.
  bool get isSurface;
  @override

  /// Maximum number of floors in this location.
  /// 1 for surface locations, higher for dungeons/caves.
  int get maxDepth;
  @override

  /// The generator ID used to create this location's map.
  /// Maps to a specific map generation algorithm (e.g., 'dungeon', 'cave', 'surface').
  String get generatorType;
  @override

  /// Optional ambient music track ID for this location.
  String? get ambientMusic;
  @override

  /// List of monster config IDs that can spawn in this location.
  List<String> get monsterPool;
  @override

  /// List of item config IDs that can spawn in this location.
  List<String> get itemPool;
  @override
  @JsonKey(ignore: true)
  _$$LocationConfigImplCopyWith<_$LocationConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
