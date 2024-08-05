import 'package:json_annotation/json_annotation.dart';

part 'tag_model.g.dart';

@JsonSerializable()
class TagModel {
  int? id;
  String? name;
  String? gif;
  String? avatar;
  String? race;
  String? description;
  int? attack;
  int? defense;
  int? ruby;
  int? coin;
  int? quantity;

  TagModel({
    this.id,
    this.name,
    this.gif,
    this.avatar,
    this.race,
    this.description,
    this.attack,
    this.defense,
    this.ruby,
    this.coin,
    this.quantity,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);
  Map<String, dynamic> toJson() => _$TagModelToJson(this);
}
