import 'package:json_annotation/json_annotation.dart';

part 'tag_background_model.g.dart';

@JsonSerializable()
class TagBackgroundModel {
  int? id;
  String? name;
  String? gif;

  TagBackgroundModel({
    this.id,
    this.name,
    this.gif,
  });

  factory TagBackgroundModel.fromJson(Map<String, dynamic> json) =>
      _$TagBackgroundModelFromJson(json);
  Map<String, dynamic> toJson() => _$TagBackgroundModelToJson(this);
}
