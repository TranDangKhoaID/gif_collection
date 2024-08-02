import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tag_model.g.dart';

@JsonSerializable()
class TagModel {
  String? id;
  String? name;
  String? gif;
  String? avatar;
  String? race;
  String? description;
  int? attack;
  int? defense;
  int? ruby;
  int? coin;

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
  });

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);
  Map<String, dynamic> toJson() => _$TagModelToJson(this);
}

List<TagModel> tags = [
  TagModel(
    id: '1',
    name: 'Horned Slime',
    gif:
        'https://th.bing.com/th/id/R.0d84b92f4a312709a73ccb9d9cae5635?rik=DdWhlW8WHSNd2w&riu=http%3a%2f%2f38.media.tumblr.com%2fce26db63031c801176260f05ae16c9bc%2ftumblr_nf8zkv41sF1sulisxo1_400.gif&ehk=IJ4yNxFCbbJkW3Qb5%2bMi%2fkIytIJCpW3zY%2bCLwVpshdM%3d&risl=&pid=ImgRaw&r=0',
    avatar: '',
    race: 'monster',
    attack: 1000,
    defense: 500,
    description:
        'Slime xanh lá có sừng là một sinh vật mềm mại, màu xanh lá cây với một cặp sừng nhô ra từ đầu. Nó di chuyển chậm và thường không gây nguy hiểm lớn, nhưng có thể tấn công nếu bị kích động.',
    ruby: 999,
  ),
  TagModel(
    id: '2',
    name: 'demon',
    gif:
        'https://th.bing.com/th/id/R.38b026268a0494b57b02255be643b496?rik=%2fop0oIPFKkwlSQ&riu=http%3a%2f%2forig08.deviantart.net%2fcf9a%2ff%2f2015%2f089%2f2%2f3%2fculcidemofire_by_fomedome-d8npvs4.gif&ehk=YRE6J6sAAOXWIc6c9Afg4PrNZrunrmumbzO3e4br8M4%3d&risl=&pid=ImgRaw&r=0',
    avatar: '',
    race: 'monster',
    attack: 900,
    defense: 100,
    coin: 100000000,
  ),
  TagModel(
      id: '3',
      name: 'flame',
      gif:
          'https://th.bing.com/th/id/R.610bb7d06b8162778ce14565daefb25a?rik=SNYZw9OdwluTLg&riu=http%3a%2f%2f33.media.tumblr.com%2f85d587752adb11c8beb669e9bbc57699%2ftumblr_nokkohY5Zf1sulisxo1_1280.gif&ehk=jygqsPRYCtCcyJj3ni3fkbJaPeqXoSNe8ylklCgsynI%3d&risl=&pid=ImgRaw&r=0',
      avatar: '',
      race: 'monster',
      attack: 1900,
      defense: 10,
      ruby: 999),
  TagModel(
    id: '4',
    name: 'Moonlit Basilysk',
    gif:
        'https://i.pinimg.com/originals/a6/a7/14/a6a714c4caab8f29b00e36feecc37fc2.gif',
    avatar: '',
    race: 'monster',
    attack: 2000,
    defense: 2000,
    ruby: 999,
  ),
];
