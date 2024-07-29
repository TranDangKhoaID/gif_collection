// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionModel _$MissionModelFromJson(Map<String, dynamic> json) => MissionModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      rubyRewards: (json['rubyRewards'] as num?)?.toInt(),
      coinRewards: (json['coinRewards'] as num?)?.toInt(),
      complete: json['complete'] as bool,
    );

Map<String, dynamic> _$MissionModelToJson(MissionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rubyRewards': instance.rubyRewards,
      'coinRewards': instance.coinRewards,
      'complete': instance.complete,
    };
