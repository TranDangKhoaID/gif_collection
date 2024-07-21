// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      ruby: (json['ruby'] as num?)?.toInt(),
      cash: (json['cash'] as num?)?.toInt(),
      treeCashLevel: (json['treeCashLevel'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'ruby': instance.ruby,
      'cash': instance.cash,
      'treeCashLevel': instance.treeCashLevel,
    };
