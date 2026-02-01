// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monster_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LootEntryImpl _$$LootEntryImplFromJson(Map<String, dynamic> json) =>
    _$LootEntryImpl(
      itemConfigId: json['itemConfigId'] as String,
      chance: (json['chance'] as num).toDouble(),
    );

Map<String, dynamic> _$$LootEntryImplToJson(_$LootEntryImpl instance) =>
    <String, dynamic>{
      'itemConfigId': instance.itemConfigId,
      'chance': instance.chance,
    };

_$MonsterConfigImpl _$$MonsterConfigImplFromJson(Map<String, dynamic> json) =>
    _$MonsterConfigImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      baseHealth: (json['baseHealth'] as num).toInt(),
      baseDamage: (json['baseDamage'] as num).toInt(),
      baseDefense: (json['baseDefense'] as num).toInt(),
      spriteId: json['spriteId'] as String,
      behavior: $enumDecode(_$MonsterBehaviourEnumMap, json['behavior']),
      aggroRange: (json['aggroRange'] as num).toInt(),
      xpValue: (json['xpValue'] as num).toInt(),
      speed: (json['speed'] as num).toInt(),
      colorValue: (json['colorValue'] as num).toInt(),
      lootTable: (json['lootTable'] as List<dynamic>?)
              ?.map((e) => LootEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MonsterConfigImplToJson(_$MonsterConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'baseHealth': instance.baseHealth,
      'baseDamage': instance.baseDamage,
      'baseDefense': instance.baseDefense,
      'spriteId': instance.spriteId,
      'behavior': _$MonsterBehaviourEnumMap[instance.behavior]!,
      'aggroRange': instance.aggroRange,
      'xpValue': instance.xpValue,
      'speed': instance.speed,
      'colorValue': instance.colorValue,
      'lootTable': instance.lootTable,
    };

const _$MonsterBehaviourEnumMap = {
  MonsterBehaviour.passive: 'passive',
  MonsterBehaviour.aggressive: 'aggressive',
  MonsterBehaviour.territorial: 'territorial',
  MonsterBehaviour.cowardly: 'cowardly',
};
