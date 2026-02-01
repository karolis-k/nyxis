// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerImpl _$$PlayerImplFromJson(Map<String, dynamic> json) => _$PlayerImpl(
      id: json['id'] as String,
      position: Position.fromJson(json['position'] as Map<String, dynamic>),
      health: (json['health'] as num).toInt(),
      maxHealth: (json['maxHealth'] as num).toInt(),
      attack: (json['attack'] as num).toInt(),
      defense: (json['defense'] as num).toInt(),
      inventoryItemIds: (json['inventoryItemIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      equippedWeaponId: json['equippedWeaponId'] as String?,
      equippedArmorId: json['equippedArmorId'] as String?,
      speed: (json['speed'] as num?)?.toInt() ?? 100,
      energy: (json['energy'] as num?)?.toInt() ?? 0,
      experience: (json['experience'] as num?)?.toInt() ?? 0,
      score: (json['score'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PlayerImplToJson(_$PlayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'health': instance.health,
      'maxHealth': instance.maxHealth,
      'attack': instance.attack,
      'defense': instance.defense,
      'inventoryItemIds': instance.inventoryItemIds,
      'equippedWeaponId': instance.equippedWeaponId,
      'equippedArmorId': instance.equippedArmorId,
      'speed': instance.speed,
      'energy': instance.energy,
      'experience': instance.experience,
      'score': instance.score,
    };
