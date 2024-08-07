import 'package:json_annotation/json_annotation.dart';

part 'my_tag_model.g.dart';

@JsonSerializable()
class MyTagModel {
  String? id;
  String? name;
  String? gif;
  String? avatar;
  String? race;
  String? description;
  int? rarity;
  int? attack;
  int? defense;

  MyTagModel({
    this.id,
    this.name,
    this.gif,
    this.avatar,
    this.race,
    this.description,
    this.rarity,
    this.attack,
    this.defense,
  });

  factory MyTagModel.fromJson(Map<String, dynamic> json) =>
      _$MyTagModelFromJson(json);
  Map<String, dynamic> toJson() => _$MyTagModelToJson(this);
}
