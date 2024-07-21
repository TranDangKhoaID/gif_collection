import 'package:flutter/material.dart';

class CharacterModel {
  String? url;
  String? name;
  Color? color;

  CharacterModel({
    this.url,
    this.name,
    this.color,
  });
}

List<CharacterModel> characters = [
  CharacterModel(
    url:
        'https://th.bing.com/th/id/OIP.OzkS9KxkZhIXJWWBeNW4xwHaLI?rs=1&pid=ImgDetMain',
    name: 'khoa',
    color: Colors.blue,
  ),
  CharacterModel(
    url: 'https://pngimg.com/uploads/anime_girl/anime_girl_PNG5.png',
    name: 'Phấn',
    color: Colors.purple,
  ),
  CharacterModel(
    url:
        'https://th.bing.com/th/id/OIP.wrUbGeQ2UbIhSjAsne0HHAHaVP?rs=1&pid=ImgDetMain',
    name: 'Đại',
    color: Colors.green,
  ),
  CharacterModel(
    url:
        'https://th.bing.com/th/id/OIP.qDYG-TCEBenKYs46Xxh68gHaJ7?rs=1&pid=ImgDetMain',
    name: 'Hiếu',
    color: Colors.green,
  ),
];
