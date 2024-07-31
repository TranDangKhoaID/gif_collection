import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? id;
  String? email;
  String? name;
  String? avatar;
  // int? ruby;
  // int? cash;
  //int? treeCashLevel;

  UserModel({
    this.id,
    this.name,
    this.avatar,
    this.email,
    // this.ruby,
    // this.cash,
    //this.treeCashLevel,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
