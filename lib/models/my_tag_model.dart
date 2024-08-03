import 'package:json_annotation/json_annotation.dart';

part 'my_tag_model.g.dart';

@JsonSerializable()
class MyTagModel {
  int? id;
  String? name;
  String? gif;
  String? avatar;
  String? race;
  String? description;
  int? attack;
  int? defense;

  MyTagModel({
    this.id,
    this.name,
    this.gif,
    this.avatar,
    this.race,
    this.description,
    this.attack,
    this.defense,
  });

  factory MyTagModel.fromJson(Map<String, dynamic> json) =>
      _$MyTagModelFromJson(json);
  Map<String, dynamic> toJson() => _$MyTagModelToJson(this);
}
