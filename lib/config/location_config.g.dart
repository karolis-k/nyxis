// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationConfigImpl _$$LocationConfigImplFromJson(Map<String, dynamic> json) =>
    _$LocationConfigImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$LocationTypeEnumMap, json['type']),
      isSurface: json['isSurface'] as bool,
      maxDepth: (json['maxDepth'] as num).toInt(),
      generatorType: json['generatorType'] as String,
      ambientMusic: json['ambientMusic'] as String?,
      monsterPool: (json['monsterPool'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      itemPool: (json['itemPool'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$LocationConfigImplToJson(
        _$LocationConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$LocationTypeEnumMap[instance.type]!,
      'isSurface': instance.isSurface,
      'maxDepth': instance.maxDepth,
      'generatorType': instance.generatorType,
      'ambientMusic': instance.ambientMusic,
      'monsterPool': instance.monsterPool,
      'itemPool': instance.itemPool,
    };

const _$LocationTypeEnumMap = {
  LocationType.dungeon: 'dungeon',
  LocationType.cave: 'cave',
  LocationType.surface: 'surface',
  LocationType.town: 'town',
};
