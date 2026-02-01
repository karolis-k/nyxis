// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) =>
    _$LocationImpl(
      id: json['id'] as String,
      configId: json['configId'] as String,
      floor: (json['floor'] as num).toInt(),
      map: GameMap.fromJson(json['map'] as Map<String, dynamic>),
      monsterIds: (json['monsterIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      itemIds: (json['itemIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      worldObjectIds: (json['worldObjectIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      visited: json['visited'] as bool? ?? false,
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'configId': instance.configId,
      'floor': instance.floor,
      'map': instance.map,
      'monsterIds': instance.monsterIds,
      'itemIds': instance.itemIds,
      'worldObjectIds': instance.worldObjectIds,
      'visited': instance.visited,
    };
