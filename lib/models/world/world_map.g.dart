// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapTileImpl _$$MapTileImplFromJson(Map<String, dynamic> json) =>
    _$MapTileImpl(
      terrain: $enumDecode(_$TerrainTypeEnumMap, json['terrain']),
      locationId: json['locationId'] as String?,
      discovered: json['discovered'] as bool? ?? false,
      visited: json['visited'] as bool? ?? false,
    );

Map<String, dynamic> _$$MapTileImplToJson(_$MapTileImpl instance) =>
    <String, dynamic>{
      'terrain': _$TerrainTypeEnumMap[instance.terrain]!,
      'locationId': instance.locationId,
      'discovered': instance.discovered,
      'visited': instance.visited,
    };

const _$TerrainTypeEnumMap = {
  TerrainType.plains: 'plains',
  TerrainType.forest: 'forest',
  TerrainType.mountain: 'mountain',
  TerrainType.water: 'water',
  TerrainType.desert: 'desert',
  TerrainType.road: 'road',
};

_$WorldMapImpl _$$WorldMapImplFromJson(Map<String, dynamic> json) =>
    _$WorldMapImpl(
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      tiles: (json['tiles'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => MapTile.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      playerPosition: json['playerPosition'] == null
          ? const Position(x: 5, y: 5)
          : Position.fromJson(json['playerPosition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WorldMapImplToJson(_$WorldMapImpl instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'tiles': instance.tiles,
      'playerPosition': instance.playerPosition,
    };
