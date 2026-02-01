// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameState _$GameStateFromJson(Map<String, dynamic> json) {
  return _GameState.fromJson(json);
}

/// @nodoc
mixin _$GameState {
  /// The player entity
  Player get player => throw _privateConstructorUsedError;

  /// ID of the current location the player is in
  String get currentLocationId => throw _privateConstructorUsedError;

  /// Current dungeon floor (0 = surface/town, positive = dungeon depth)
  int get currentFloor => throw _privateConstructorUsedError;

  /// All locations in the game world, keyed by locationId
  Map<String, Location> get locations => throw _privateConstructorUsedError;

  /// All active monsters in the current location, keyed by monsterId
  Map<String, Monster> get monsters => throw _privateConstructorUsedError;

  /// All items in the world (not in inventory), keyed by itemId
  Map<String, Item> get items => throw _privateConstructorUsedError;

  /// All world objects (portals, chests, etc.), keyed by objectId
  Map<String, WorldObject> get worldObjects =>
      throw _privateConstructorUsedError;

  /// Current turn number (increments each time player takes an action)
  int get turnNumber => throw _privateConstructorUsedError;

  /// Whether it's currently the player's turn to act
  bool get isPlayerTurn => throw _privateConstructorUsedError;

  /// Current game status
  GameStatus get status => throw _privateConstructorUsedError;

  /// The world map for overworld navigation
  WorldMap? get worldMap => throw _privateConstructorUsedError;

  /// Whether the player is currently on the world map (vs in a location)
  bool get isOnWorldMap => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {Player player,
      String currentLocationId,
      int currentFloor,
      Map<String, Location> locations,
      Map<String, Monster> monsters,
      Map<String, Item> items,
      Map<String, WorldObject> worldObjects,
      int turnNumber,
      bool isPlayerTurn,
      GameStatus status,
      WorldMap? worldMap,
      bool isOnWorldMap});

  $PlayerCopyWith<$Res> get player;
  $WorldMapCopyWith<$Res>? get worldMap;
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? currentLocationId = null,
    Object? currentFloor = null,
    Object? locations = null,
    Object? monsters = null,
    Object? items = null,
    Object? worldObjects = null,
    Object? turnNumber = null,
    Object? isPlayerTurn = null,
    Object? status = null,
    Object? worldMap = freezed,
    Object? isOnWorldMap = null,
  }) {
    return _then(_value.copyWith(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as Player,
      currentLocationId: null == currentLocationId
          ? _value.currentLocationId
          : currentLocationId // ignore: cast_nullable_to_non_nullable
              as String,
      currentFloor: null == currentFloor
          ? _value.currentFloor
          : currentFloor // ignore: cast_nullable_to_non_nullable
              as int,
      locations: null == locations
          ? _value.locations
          : locations // ignore: cast_nullable_to_non_nullable
              as Map<String, Location>,
      monsters: null == monsters
          ? _value.monsters
          : monsters // ignore: cast_nullable_to_non_nullable
              as Map<String, Monster>,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as Map<String, Item>,
      worldObjects: null == worldObjects
          ? _value.worldObjects
          : worldObjects // ignore: cast_nullable_to_non_nullable
              as Map<String, WorldObject>,
      turnNumber: null == turnNumber
          ? _value.turnNumber
          : turnNumber // ignore: cast_nullable_to_non_nullable
              as int,
      isPlayerTurn: null == isPlayerTurn
          ? _value.isPlayerTurn
          : isPlayerTurn // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      worldMap: freezed == worldMap
          ? _value.worldMap
          : worldMap // ignore: cast_nullable_to_non_nullable
              as WorldMap?,
      isOnWorldMap: null == isOnWorldMap
          ? _value.isOnWorldMap
          : isOnWorldMap // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res> get player {
    return $PlayerCopyWith<$Res>(_value.player, (value) {
      return _then(_value.copyWith(player: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WorldMapCopyWith<$Res>? get worldMap {
    if (_value.worldMap == null) {
      return null;
    }

    return $WorldMapCopyWith<$Res>(_value.worldMap!, (value) {
      return _then(_value.copyWith(worldMap: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Player player,
      String currentLocationId,
      int currentFloor,
      Map<String, Location> locations,
      Map<String, Monster> monsters,
      Map<String, Item> items,
      Map<String, WorldObject> worldObjects,
      int turnNumber,
      bool isPlayerTurn,
      GameStatus status,
      WorldMap? worldMap,
      bool isOnWorldMap});

  @override
  $PlayerCopyWith<$Res> get player;
  @override
  $WorldMapCopyWith<$Res>? get worldMap;
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? currentLocationId = null,
    Object? currentFloor = null,
    Object? locations = null,
    Object? monsters = null,
    Object? items = null,
    Object? worldObjects = null,
    Object? turnNumber = null,
    Object? isPlayerTurn = null,
    Object? status = null,
    Object? worldMap = freezed,
    Object? isOnWorldMap = null,
  }) {
    return _then(_$GameStateImpl(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as Player,
      currentLocationId: null == currentLocationId
          ? _value.currentLocationId
          : currentLocationId // ignore: cast_nullable_to_non_nullable
              as String,
      currentFloor: null == currentFloor
          ? _value.currentFloor
          : currentFloor // ignore: cast_nullable_to_non_nullable
              as int,
      locations: null == locations
          ? _value._locations
          : locations // ignore: cast_nullable_to_non_nullable
              as Map<String, Location>,
      monsters: null == monsters
          ? _value._monsters
          : monsters // ignore: cast_nullable_to_non_nullable
              as Map<String, Monster>,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as Map<String, Item>,
      worldObjects: null == worldObjects
          ? _value._worldObjects
          : worldObjects // ignore: cast_nullable_to_non_nullable
              as Map<String, WorldObject>,
      turnNumber: null == turnNumber
          ? _value.turnNumber
          : turnNumber // ignore: cast_nullable_to_non_nullable
              as int,
      isPlayerTurn: null == isPlayerTurn
          ? _value.isPlayerTurn
          : isPlayerTurn // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      worldMap: freezed == worldMap
          ? _value.worldMap
          : worldMap // ignore: cast_nullable_to_non_nullable
              as WorldMap?,
      isOnWorldMap: null == isOnWorldMap
          ? _value.isOnWorldMap
          : isOnWorldMap // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameStateImpl extends _GameState {
  const _$GameStateImpl(
      {required this.player,
      required this.currentLocationId,
      this.currentFloor = 0,
      final Map<String, Location> locations = const {},
      final Map<String, Monster> monsters = const {},
      final Map<String, Item> items = const {},
      final Map<String, WorldObject> worldObjects = const {},
      this.turnNumber = 0,
      this.isPlayerTurn = true,
      this.status = GameStatus.playing,
      this.worldMap,
      this.isOnWorldMap = false})
      : _locations = locations,
        _monsters = monsters,
        _items = items,
        _worldObjects = worldObjects,
        super._();

  factory _$GameStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStateImplFromJson(json);

  /// The player entity
  @override
  final Player player;

  /// ID of the current location the player is in
  @override
  final String currentLocationId;

  /// Current dungeon floor (0 = surface/town, positive = dungeon depth)
  @override
  @JsonKey()
  final int currentFloor;

  /// All locations in the game world, keyed by locationId
  final Map<String, Location> _locations;

  /// All locations in the game world, keyed by locationId
  @override
  @JsonKey()
  Map<String, Location> get locations {
    if (_locations is EqualUnmodifiableMapView) return _locations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_locations);
  }

  /// All active monsters in the current location, keyed by monsterId
  final Map<String, Monster> _monsters;

  /// All active monsters in the current location, keyed by monsterId
  @override
  @JsonKey()
  Map<String, Monster> get monsters {
    if (_monsters is EqualUnmodifiableMapView) return _monsters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_monsters);
  }

  /// All items in the world (not in inventory), keyed by itemId
  final Map<String, Item> _items;

  /// All items in the world (not in inventory), keyed by itemId
  @override
  @JsonKey()
  Map<String, Item> get items {
    if (_items is EqualUnmodifiableMapView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_items);
  }

  /// All world objects (portals, chests, etc.), keyed by objectId
  final Map<String, WorldObject> _worldObjects;

  /// All world objects (portals, chests, etc.), keyed by objectId
  @override
  @JsonKey()
  Map<String, WorldObject> get worldObjects {
    if (_worldObjects is EqualUnmodifiableMapView) return _worldObjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_worldObjects);
  }

  /// Current turn number (increments each time player takes an action)
  @override
  @JsonKey()
  final int turnNumber;

  /// Whether it's currently the player's turn to act
  @override
  @JsonKey()
  final bool isPlayerTurn;

  /// Current game status
  @override
  @JsonKey()
  final GameStatus status;

  /// The world map for overworld navigation
  @override
  final WorldMap? worldMap;

  /// Whether the player is currently on the world map (vs in a location)
  @override
  @JsonKey()
  final bool isOnWorldMap;

  @override
  String toString() {
    return 'GameState(player: $player, currentLocationId: $currentLocationId, currentFloor: $currentFloor, locations: $locations, monsters: $monsters, items: $items, worldObjects: $worldObjects, turnNumber: $turnNumber, isPlayerTurn: $isPlayerTurn, status: $status, worldMap: $worldMap, isOnWorldMap: $isOnWorldMap)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            (identical(other.player, player) || other.player == player) &&
            (identical(other.currentLocationId, currentLocationId) ||
                other.currentLocationId == currentLocationId) &&
            (identical(other.currentFloor, currentFloor) ||
                other.currentFloor == currentFloor) &&
            const DeepCollectionEquality()
                .equals(other._locations, _locations) &&
            const DeepCollectionEquality().equals(other._monsters, _monsters) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality()
                .equals(other._worldObjects, _worldObjects) &&
            (identical(other.turnNumber, turnNumber) ||
                other.turnNumber == turnNumber) &&
            (identical(other.isPlayerTurn, isPlayerTurn) ||
                other.isPlayerTurn == isPlayerTurn) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.worldMap, worldMap) ||
                other.worldMap == worldMap) &&
            (identical(other.isOnWorldMap, isOnWorldMap) ||
                other.isOnWorldMap == isOnWorldMap));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      player,
      currentLocationId,
      currentFloor,
      const DeepCollectionEquality().hash(_locations),
      const DeepCollectionEquality().hash(_monsters),
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_worldObjects),
      turnNumber,
      isPlayerTurn,
      status,
      worldMap,
      isOnWorldMap);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameStateImplToJson(
      this,
    );
  }
}

abstract class _GameState extends GameState {
  const factory _GameState(
      {required final Player player,
      required final String currentLocationId,
      final int currentFloor,
      final Map<String, Location> locations,
      final Map<String, Monster> monsters,
      final Map<String, Item> items,
      final Map<String, WorldObject> worldObjects,
      final int turnNumber,
      final bool isPlayerTurn,
      final GameStatus status,
      final WorldMap? worldMap,
      final bool isOnWorldMap}) = _$GameStateImpl;
  const _GameState._() : super._();

  factory _GameState.fromJson(Map<String, dynamic> json) =
      _$GameStateImpl.fromJson;

  @override

  /// The player entity
  Player get player;
  @override

  /// ID of the current location the player is in
  String get currentLocationId;
  @override

  /// Current dungeon floor (0 = surface/town, positive = dungeon depth)
  int get currentFloor;
  @override

  /// All locations in the game world, keyed by locationId
  Map<String, Location> get locations;
  @override

  /// All active monsters in the current location, keyed by monsterId
  Map<String, Monster> get monsters;
  @override

  /// All items in the world (not in inventory), keyed by itemId
  Map<String, Item> get items;
  @override

  /// All world objects (portals, chests, etc.), keyed by objectId
  Map<String, WorldObject> get worldObjects;
  @override

  /// Current turn number (increments each time player takes an action)
  int get turnNumber;
  @override

  /// Whether it's currently the player's turn to act
  bool get isPlayerTurn;
  @override

  /// Current game status
  GameStatus get status;
  @override

  /// The world map for overworld navigation
  WorldMap? get worldMap;
  @override

  /// Whether the player is currently on the world map (vs in a location)
  bool get isOnWorldMap;
  @override
  @JsonKey(ignore: true)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
