import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'mission_model.g.dart';

@JsonSerializable()
class MissionModel {
  String? id;
  String? name;
  int? rubyRewards;
  int? coinRewards;
  bool complete;

  MissionModel({
    this.id,
    this.name,
    this.rubyRewards,
    this.coinRewards,
    required this.complete,
  });

  factory MissionModel.fromRawJson(String str) =>
      MissionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MissionModel.fromJson(Map<String, dynamic> json) =>
      _$MissionModelFromJson(json);
  Map<String, dynamic> toJson() => _$MissionModelToJson(this);
}
