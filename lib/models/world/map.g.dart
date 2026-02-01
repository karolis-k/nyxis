// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameMapImpl _$$GameMapImplFromJson(Map<String, dynamic> json) =>
    _$GameMapImpl(
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      tiles: (json['tiles'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => Tile.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$$GameMapImplToJson(_$GameMapImpl instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'tiles': instance.tiles,
    };
