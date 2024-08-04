// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_background_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagBackgroundModel _$TagBackgroundModelFromJson(Map<String, dynamic> json) =>
    TagBackgroundModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      gif: json['gif'] as String?,
    );

Map<String, dynamic> _$TagBackgroundModelToJson(TagBackgroundModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gif': instance.gif,
    };
