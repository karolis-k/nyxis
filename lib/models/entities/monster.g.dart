// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monster.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MonsterImpl _$$MonsterImplFromJson(Map<String, dynamic> json) =>
    _$MonsterImpl(
      id: json['id'] as String,
      configId: json['configId'] as String,
      position: Position.fromJson(json['position'] as Map<String, dynamic>),
      health: (json['health'] as num).toInt(),
      maxHealth: (json['maxHealth'] as num).toInt(),
      aiState: $enumDecodeNullable(_$AIStateEnumMap, json['aiState']) ??
          AIState.idle,
      energy: (json['energy'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$MonsterImplToJson(_$MonsterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'configId': instance.configId,
      'position': instance.position,
      'health': instance.health,
      'maxHealth': instance.maxHealth,
      'aiState': _$AIStateEnumMap[instance.aiState]!,
      'energy': instance.energy,
    };

const _$AIStateEnumMap = {
  AIState.idle: 'idle',
  AIState.chasing: 'chasing',
  AIState.attacking: 'attacking',
  AIState.fleeing: 'fleeing',
};
