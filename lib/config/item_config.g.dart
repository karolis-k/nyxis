// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemConfigImpl _$$ItemConfigImplFromJson(Map<String, dynamic> json) =>
    _$ItemConfigImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$ItemTypeEnumMap, json['type']),
      rarity: $enumDecode(_$ItemRarityEnumMap, json['rarity']),
      spriteId: json['spriteId'] as String,
      description: json['description'] as String,
      value: (json['value'] as num?)?.toInt() ?? 0,
      stackable: json['stackable'] as bool? ?? false,
      properties: json['properties'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$ItemConfigImplToJson(_$ItemConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$ItemTypeEnumMap[instance.type]!,
      'rarity': _$ItemRarityEnumMap[instance.rarity]!,
      'spriteId': instance.spriteId,
      'description': instance.description,
      'value': instance.value,
      'stackable': instance.stackable,
      'properties': instance.properties,
    };

const _$ItemTypeEnumMap = {
  ItemType.weapon: 'weapon',
  ItemType.armor: 'armor',
  ItemType.consumable: 'consumable',
  ItemType.key: 'key',
  ItemType.treasure: 'treasure',
};

const _$ItemRarityEnumMap = {
  ItemRarity.common: 'common',
  ItemRarity.uncommon: 'uncommon',
  ItemRarity.rare: 'rare',
  ItemRarity.epic: 'epic',
  ItemRarity.legendary: 'legendary',
};
