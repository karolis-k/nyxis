// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TileImpl _$$TileImplFromJson(Map<String, dynamic> json) => _$TileImpl(
      type: $enumDecode(_$TileTypeEnumMap, json['type']),
      walkable: json['walkable'] as bool? ?? true,
      feature: $enumDecodeNullable(_$TileFeatureEnumMap, json['feature']),
      effect: $enumDecodeNullable(_$TileEffectEnumMap, json['effect']),
      contents: (json['contents'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      explored: json['explored'] as bool? ?? false,
      visible: json['visible'] as bool? ?? false,
    );

Map<String, dynamic> _$$TileImplToJson(_$TileImpl instance) =>
    <String, dynamic>{
      'type': _$TileTypeEnumMap[instance.type]!,
      'walkable': instance.walkable,
      'feature': _$TileFeatureEnumMap[instance.feature],
      'effect': _$TileEffectEnumMap[instance.effect],
      'contents': instance.contents,
      'explored': instance.explored,
      'visible': instance.visible,
    };

const _$TileTypeEnumMap = {
  TileType.floor: 'floor',
  TileType.wall: 'wall',
  TileType.door: 'door',
  TileType.stairsUp: 'stairsUp',
  TileType.stairsDown: 'stairsDown',
  TileType.water: 'water',
  TileType.lava: 'lava',
};

const _$TileFeatureEnumMap = {
  TileFeature.water: 'water',
  TileFeature.deepWater: 'deepWater',
  TileFeature.moss: 'moss',
  TileFeature.grass: 'grass',
  TileFeature.rubble: 'rubble',
  TileFeature.ice: 'ice',
  TileFeature.lava: 'lava',
  TileFeature.mud: 'mud',
};

const _$TileEffectEnumMap = {
  TileEffect.burning: 'burning',
  TileEffect.frozen: 'frozen',
  TileEffect.poisoned: 'poisoned',
  TileEffect.electrified: 'electrified',
  TileEffect.blessed: 'blessed',
  TileEffect.cursed: 'cursed',
  TileEffect.darkness: 'darkness',
};
