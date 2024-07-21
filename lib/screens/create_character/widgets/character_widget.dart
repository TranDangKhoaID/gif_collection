import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_tikimon_collection/models/character_model.dart';
import 'package:flutter/material.dart';

class CharacterWidget extends StatelessWidget {
  final CharacterModel character;
  const CharacterWidget({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            alignment: Alignment.center,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: character.url.toString(),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
