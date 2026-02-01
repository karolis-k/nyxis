// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameStateImpl _$$GameStateImplFromJson(Map<String, dynamic> json) =>
    _$GameStateImpl(
      player: Player.fromJson(json['player'] as Map<String, dynamic>),
      currentLocationId: json['currentLocationId'] as String,
      currentFloor: (json['currentFloor'] as num?)?.toInt() ?? 0,
      locations: (json['locations'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Location.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      monsters: (json['monsters'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Monster.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      items: (json['items'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Item.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      worldObjects: (json['worldObjects'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, WorldObject.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      turnNumber: (json['turnNumber'] as num?)?.toInt() ?? 0,
      isPlayerTurn: json['isPlayerTurn'] as bool? ?? true,
      status: $enumDecodeNullable(_$GameStatusEnumMap, json['status']) ??
          GameStatus.playing,
      worldMap: json['worldMap'] == null
          ? null
          : WorldMap.fromJson(json['worldMap'] as Map<String, dynamic>),
      isOnWorldMap: json['isOnWorldMap'] as bool? ?? false,
    );

Map<String, dynamic> _$$GameStateImplToJson(_$GameStateImpl instance) =>
    <String, dynamic>{
      'player': instance.player,
      'currentLocationId': instance.currentLocationId,
      'currentFloor': instance.currentFloor,
      'locations': instance.locations,
      'monsters': instance.monsters,
      'items': instance.items,
      'worldObjects': instance.worldObjects,
      'turnNumber': instance.turnNumber,
      'isPlayerTurn': instance.isPlayerTurn,
      'status': _$GameStatusEnumMap[instance.status]!,
      'worldMap': instance.worldMap,
      'isOnWorldMap': instance.isOnWorldMap,
    };

const _$GameStatusEnumMap = {
  GameStatus.playing: 'playing',
  GameStatus.paused: 'paused',
  GameStatus.gameOver: 'gameOver',
  GameStatus.victory: 'victory',
};
