// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyTagModel _$MyTagModelFromJson(Map<String, dynamic> json) => MyTagModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      gif: json['gif'] as String?,
      avatar: json['avatar'] as String?,
      race: json['race'] as String?,
      description: json['description'] as String?,
      rarity: (json['rarity'] as num?)?.toInt(),
      attack: (json['attack'] as num?)?.toInt(),
      defense: (json['defense'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MyTagModelToJson(MyTagModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gif': instance.gif,
      'avatar': instance.avatar,
      'race': instance.race,
      'description': instance.description,
      'rarity': instance.rarity,
      'attack': instance.attack,
      'defense': instance.defense,
    };
