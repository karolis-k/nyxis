// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portal_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PortalDefinitionImpl _$$PortalDefinitionImplFromJson(
        Map<String, dynamic> json) =>
    _$PortalDefinitionImpl(
      id: json['id'] as String,
      location1: json['location1'] as String,
      location2: json['location2'] as String,
      displayName1: json['displayName1'] as String,
      displayName2: json['displayName2'] as String,
      floor1: (json['floor1'] as num).toInt(),
      floor2: (json['floor2'] as num).toInt(),
    );

Map<String, dynamic> _$$PortalDefinitionImplToJson(
        _$PortalDefinitionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location1': instance.location1,
      'location2': instance.location2,
      'displayName1': instance.displayName1,
      'displayName2': instance.displayName2,
      'floor1': instance.floor1,
      'floor2': instance.floor2,
    };
