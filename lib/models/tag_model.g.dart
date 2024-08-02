// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagModel _$TagModelFromJson(Map<String, dynamic> json) => TagModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      gif: json['gif'] as String?,
      avatar: json['avatar'] as String?,
      race: json['race'] as String?,
      description: json['description'] as String?,
      attack: (json['attack'] as num?)?.toInt(),
      defense: (json['defense'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TagModelToJson(TagModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gif': instance.gif,
      'avatar': instance.avatar,
      'race': instance.race,
      'description': instance.description,
      'attack': instance.attack,
      'defense': instance.defense,
    };
