// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Location _$LocationFromJson(Map<String, dynamic> json) {
  return _Location.fromJson(json);
}

/// @nodoc
mixin _$Location {
  /// Unique identifier for this location instance
  /// Format: "{configId}_{floor}" e.g., "dungeon_1_2"
  String get id => throw _privateConstructorUsedError;

  /// Reference to the LocationRegistry config
  /// Defines the type and generation rules for this location
  String get configId => throw _privateConstructorUsedError;

  /// Current floor number (0-indexed)
  /// 0 is the top/entrance floor, higher numbers are deeper
  int get floor => throw _privateConstructorUsedError;

  /// The game map for this location
  GameMap get map => throw _privateConstructorUsedError;

  /// IDs of monsters currently in this location
  List<String> get monsterIds => throw _privateConstructorUsedError;

  /// IDs of items on the ground in this location
  List<String> get itemIds => throw _privateConstructorUsedError;

  /// IDs of world objects in this location (portals, chests, etc.)
  List<String> get worldObjectIds => throw _privateConstructorUsedError;

  /// Whether the player has visited this location before
  bool get visited => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationCopyWith<Location> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationCopyWith<$Res> {
  factory $LocationCopyWith(Location value, $Res Function(Location) then) =
      _$LocationCopyWithImpl<$Res, Location>;
  @useResult
  $Res call(
      {String id,
      String configId,
      int floor,
      GameMap map,
      List<String> monsterIds,
      List<String> itemIds,
      List<String> worldObjectIds,
      bool visited});

  $GameMapCopyWith<$Res> get map;
}

/// @nodoc
class _$LocationCopyWithImpl<$Res, $Val extends Location>
    implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? configId = null,
    Object? floor = null,
    Object? map = null,
    Object? monsterIds = null,
    Object? itemIds = null,
    Object? worldObjectIds = null,
    Object? visited = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      configId: null == configId
          ? _value.configId
          : configId // ignore: cast_nullable_to_non_nullable
              as String,
      floor: null == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as int,
      map: null == map
          ? _value.map
          : map // ignore: cast_nullable_to_non_nullable
              as GameMap,
      monsterIds: null == monsterIds
          ? _value.monsterIds
          : monsterIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      itemIds: null == itemIds
          ? _value.itemIds
          : itemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      worldObjectIds: null == worldObjectIds
          ? _value.worldObjectIds
          : worldObjectIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      visited: null == visited
          ? _value.visited
          : visited // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GameMapCopyWith<$Res> get map {
    return $GameMapCopyWith<$Res>(_value.map, (value) {
      return _then(_value.copyWith(map: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LocationImplCopyWith<$Res>
    implements $LocationCopyWith<$Res> {
  factory _$$LocationImplCopyWith(
          _$LocationImpl value, $Res Function(_$LocationImpl) then) =
      __$$LocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String configId,
      int floor,
      GameMap map,
      List<String> monsterIds,
      List<String> itemIds,
      List<String> worldObjectIds,
      bool visited});

  @override
  $GameMapCopyWith<$Res> get map;
}

/// @nodoc
class __$$LocationImplCopyWithImpl<$Res>
    extends _$LocationCopyWithImpl<$Res, _$LocationImpl>
    implements _$$LocationImplCopyWith<$Res> {
  __$$LocationImplCopyWithImpl(
      _$LocationImpl _value, $Res Function(_$LocationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? configId = null,
    Object? floor = null,
    Object? map = null,
    Object? monsterIds = null,
    Object? itemIds = null,
    Object? worldObjectIds = null,
    Object? visited = null,
  }) {
    return _then(_$LocationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      configId: null == configId
          ? _value.configId
          : configId // ignore: cast_nullable_to_non_nullable
              as String,
      floor: null == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as int,
      map: null == map
          ? _value.map
          : map // ignore: cast_nullable_to_non_nullable
              as GameMap,
      monsterIds: null == monsterIds
          ? _value._monsterIds
          : monsterIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      itemIds: null == itemIds
          ? _value._itemIds
          : itemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      worldObjectIds: null == worldObjectIds
          ? _value._worldObjectIds
          : worldObjectIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      visited: null == visited
          ? _value.visited
          : visited // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationImpl extends _Location {
  const _$LocationImpl(
      {required this.id,
      required this.configId,
      required this.floor,
      required this.map,
      final List<String> monsterIds = const [],
      final List<String> itemIds = const [],
      final List<String> worldObjectIds = const [],
      this.visited = false})
      : _monsterIds = monsterIds,
        _itemIds = itemIds,
        _worldObjectIds = worldObjectIds,
        super._();

  factory _$LocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationImplFromJson(json);

  /// Unique identifier for this location instance
  /// Format: "{configId}_{floor}" e.g., "dungeon_1_2"
  @override
  final String id;

  /// Reference to the LocationRegistry config
  /// Defines the type and generation rules for this location
  @override
  final String configId;

  /// Current floor number (0-indexed)
  /// 0 is the top/entrance floor, higher numbers are deeper
  @override
  final int floor;

  /// The game map for this location
  @override
  final GameMap map;

  /// IDs of monsters currently in this location
  final List<String> _monsterIds;

  /// IDs of monsters currently in this location
  @override
  @JsonKey()
  List<String> get monsterIds {
    if (_monsterIds is EqualUnmodifiableListView) return _monsterIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monsterIds);
  }

  /// IDs of items on the ground in this location
  final List<String> _itemIds;

  /// IDs of items on the ground in this location
  @override
  @JsonKey()
  List<String> get itemIds {
    if (_itemIds is EqualUnmodifiableListView) return _itemIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemIds);
  }

  /// IDs of world objects in this location (portals, chests, etc.)
  final List<String> _worldObjectIds;

  /// IDs of world objects in this location (portals, chests, etc.)
  @override
  @JsonKey()
  List<String> get worldObjectIds {
    if (_worldObjectIds is EqualUnmodifiableListView) return _worldObjectIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_worldObjectIds);
  }

  /// Whether the player has visited this location before
  @override
  @JsonKey()
  final bool visited;

  @override
  String toString() {
    return 'Location(id: $id, configId: $configId, floor: $floor, map: $map, monsterIds: $monsterIds, itemIds: $itemIds, worldObjectIds: $worldObjectIds, visited: $visited)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.configId, configId) ||
                other.configId == configId) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.map, map) || other.map == map) &&
            const DeepCollectionEquality()
                .equals(other._monsterIds, _monsterIds) &&
            const DeepCollectionEquality().equals(other._itemIds, _itemIds) &&
            const DeepCollectionEquality()
                .equals(other._worldObjectIds, _worldObjectIds) &&
            (identical(other.visited, visited) || other.visited == visited));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      configId,
      floor,
      map,
      const DeepCollectionEquality().hash(_monsterIds),
      const DeepCollectionEquality().hash(_itemIds),
      const DeepCollectionEquality().hash(_worldObjectIds),
      visited);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationImplCopyWith<_$LocationImpl> get copyWith =>
      __$$LocationImplCopyWithImpl<_$LocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationImplToJson(
      this,
    );
  }
}

abstract class _Location extends Location {
  const factory _Location(
      {required final String id,
      required final String configId,
      required final int floor,
      required final GameMap map,
      final List<String> monsterIds,
      final List<String> itemIds,
      final List<String> worldObjectIds,
      final bool visited}) = _$LocationImpl;
  const _Location._() : super._();

  factory _Location.fromJson(Map<String, dynamic> json) =
      _$LocationImpl.fromJson;

  @override

  /// Unique identifier for this location instance
  /// Format: "{configId}_{floor}" e.g., "dungeon_1_2"
  String get id;
  @override

  /// Reference to the LocationRegistry config
  /// Defines the type and generation rules for this location
  String get configId;
  @override

  /// Current floor number (0-indexed)
  /// 0 is the top/entrance floor, higher numbers are deeper
  int get floor;
  @override

  /// The game map for this location
  GameMap get map;
  @override

  /// IDs of monsters currently in this location
  List<String> get monsterIds;
  @override

  /// IDs of items on the ground in this location
  List<String> get itemIds;
  @override

  /// IDs of world objects in this location (portals, chests, etc.)
  List<String> get worldObjectIds;
  @override

  /// Whether the player has visited this location before
  bool get visited;
  @override
  @JsonKey(ignore: true)
  _$$LocationImplCopyWith<_$LocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
