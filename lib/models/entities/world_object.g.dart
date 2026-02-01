// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorldObjectImpl _$$WorldObjectImplFromJson(Map<String, dynamic> json) =>
    _$WorldObjectImpl(
      id: json['id'] as String,
      type: $enumDecode(_$WorldObjectTypeEnumMap, json['type']),
      position: Position.fromJson(json['position'] as Map<String, dynamic>),
      configId: json['configId'] as String,
      isInteractable: json['isInteractable'] as bool? ?? true,
    );

Map<String, dynamic> _$$WorldObjectImplToJson(_$WorldObjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$WorldObjectTypeEnumMap[instance.type]!,
      'position': instance.position,
      'configId': instance.configId,
      'isInteractable': instance.isInteractable,
    };

const _$WorldObjectTypeEnumMap = {
  WorldObjectType.portal: 'portal',
};
