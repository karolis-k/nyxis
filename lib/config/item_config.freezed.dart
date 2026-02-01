// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ItemConfig _$ItemConfigFromJson(Map<String, dynamic> json) {
  return _ItemConfig.fromJson(json);
}

/// @nodoc
mixin _$ItemConfig {
  /// Unique identifier (e.g., 'sword', 'health_potion')
  String get id => throw _privateConstructorUsedError;

  /// Display name shown to the player
  String get name => throw _privateConstructorUsedError;

  /// The type category of this item
  ItemType get type => throw _privateConstructorUsedError;

  /// Rarity tier of this item
  ItemRarity get rarity => throw _privateConstructorUsedError;

  /// Sprite identifier for rendering
  String get spriteId => throw _privateConstructorUsedError;

  /// Description shown in inventory/tooltips
  String get description => throw _privateConstructorUsedError;

  /// Base gold value for buying/selling
  int get value => throw _privateConstructorUsedError;

  /// Whether this item can stack in inventory
  bool get stackable => throw _privateConstructorUsedError;

  /// Type-specific properties (damage, healing, defense, etc.)
  Map<String, dynamic> get properties => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemConfigCopyWith<ItemConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemConfigCopyWith<$Res> {
  factory $ItemConfigCopyWith(
          ItemConfig value, $Res Function(ItemConfig) then) =
      _$ItemConfigCopyWithImpl<$Res, ItemConfig>;
  @useResult
  $Res call(
      {String id,
      String name,
      ItemType type,
      ItemRarity rarity,
      String spriteId,
      String description,
      int value,
      bool stackable,
      Map<String, dynamic> properties});
}

/// @nodoc
class _$ItemConfigCopyWithImpl<$Res, $Val extends ItemConfig>
    implements $ItemConfigCopyWith<$Res> {
  _$ItemConfigCopyWithImpl(this._value, this._then);

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
    Object? rarity = null,
    Object? spriteId = null,
    Object? description = null,
    Object? value = null,
    Object? stackable = null,
    Object? properties = null,
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
              as ItemType,
      rarity: null == rarity
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as ItemRarity,
      spriteId: null == spriteId
          ? _value.spriteId
          : spriteId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      stackable: null == stackable
          ? _value.stackable
          : stackable // ignore: cast_nullable_to_non_nullable
              as bool,
      properties: null == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemConfigImplCopyWith<$Res>
    implements $ItemConfigCopyWith<$Res> {
  factory _$$ItemConfigImplCopyWith(
          _$ItemConfigImpl value, $Res Function(_$ItemConfigImpl) then) =
      __$$ItemConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      ItemType type,
      ItemRarity rarity,
      String spriteId,
      String description,
      int value,
      bool stackable,
      Map<String, dynamic> properties});
}

/// @nodoc
class __$$ItemConfigImplCopyWithImpl<$Res>
    extends _$ItemConfigCopyWithImpl<$Res, _$ItemConfigImpl>
    implements _$$ItemConfigImplCopyWith<$Res> {
  __$$ItemConfigImplCopyWithImpl(
      _$ItemConfigImpl _value, $Res Function(_$ItemConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? rarity = null,
    Object? spriteId = null,
    Object? description = null,
    Object? value = null,
    Object? stackable = null,
    Object? properties = null,
  }) {
    return _then(_$ItemConfigImpl(
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
              as ItemType,
      rarity: null == rarity
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as ItemRarity,
      spriteId: null == spriteId
          ? _value.spriteId
          : spriteId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      stackable: null == stackable
          ? _value.stackable
          : stackable // ignore: cast_nullable_to_non_nullable
              as bool,
      properties: null == properties
          ? _value._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemConfigImpl extends _ItemConfig {
  const _$ItemConfigImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.rarity,
      required this.spriteId,
      required this.description,
      this.value = 0,
      this.stackable = false,
      final Map<String, dynamic> properties = const {}})
      : _properties = properties,
        super._();

  factory _$ItemConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemConfigImplFromJson(json);

  /// Unique identifier (e.g., 'sword', 'health_potion')
  @override
  final String id;

  /// Display name shown to the player
  @override
  final String name;

  /// The type category of this item
  @override
  final ItemType type;

  /// Rarity tier of this item
  @override
  final ItemRarity rarity;

  /// Sprite identifier for rendering
  @override
  final String spriteId;

  /// Description shown in inventory/tooltips
  @override
  final String description;

  /// Base gold value for buying/selling
  @override
  @JsonKey()
  final int value;

  /// Whether this item can stack in inventory
  @override
  @JsonKey()
  final bool stackable;

  /// Type-specific properties (damage, healing, defense, etc.)
  final Map<String, dynamic> _properties;

  /// Type-specific properties (damage, healing, defense, etc.)
  @override
  @JsonKey()
  Map<String, dynamic> get properties {
    if (_properties is EqualUnmodifiableMapView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_properties);
  }

  @override
  String toString() {
    return 'ItemConfig(id: $id, name: $name, type: $type, rarity: $rarity, spriteId: $spriteId, description: $description, value: $value, stackable: $stackable, properties: $properties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.rarity, rarity) || other.rarity == rarity) &&
            (identical(other.spriteId, spriteId) ||
                other.spriteId == spriteId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.stackable, stackable) ||
                other.stackable == stackable) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      rarity,
      spriteId,
      description,
      value,
      stackable,
      const DeepCollectionEquality().hash(_properties));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemConfigImplCopyWith<_$ItemConfigImpl> get copyWith =>
      __$$ItemConfigImplCopyWithImpl<_$ItemConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemConfigImplToJson(
      this,
    );
  }
}

abstract class _ItemConfig extends ItemConfig {
  const factory _ItemConfig(
      {required final String id,
      required final String name,
      required final ItemType type,
      required final ItemRarity rarity,
      required final String spriteId,
      required final String description,
      final int value,
      final bool stackable,
      final Map<String, dynamic> properties}) = _$ItemConfigImpl;
  const _ItemConfig._() : super._();

  factory _ItemConfig.fromJson(Map<String, dynamic> json) =
      _$ItemConfigImpl.fromJson;

  @override

  /// Unique identifier (e.g., 'sword', 'health_potion')
  String get id;
  @override

  /// Display name shown to the player
  String get name;
  @override

  /// The type category of this item
  ItemType get type;
  @override

  /// Rarity tier of this item
  ItemRarity get rarity;
  @override

  /// Sprite identifier for rendering
  String get spriteId;
  @override

  /// Description shown in inventory/tooltips
  String get description;
  @override

  /// Base gold value for buying/selling
  int get value;
  @override

  /// Whether this item can stack in inventory
  bool get stackable;
  @override

  /// Type-specific properties (damage, healing, defense, etc.)
  Map<String, dynamic> get properties;
  @override
  @JsonKey(ignore: true)
  _$$ItemConfigImplCopyWith<_$ItemConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
