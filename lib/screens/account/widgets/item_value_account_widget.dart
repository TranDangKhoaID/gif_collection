import 'package:flutter/material.dart';
import 'package:gif_collection/extensions/string.dart';

class ItemValueAccountWidget extends StatelessWidget {
  final String assets;
  final String name;
  final int value;
  const ItemValueAccountWidget({
    super.key,
    required this.assets,
    required this.name,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 7),
              width: 25,
              child: Image.asset(
                assets,
                fit: BoxFit.cover,
              ),
            ),
            Text(name),
          ],
        ),
        Text(
          formattedNumber(value),
        ),
      ],
    );
  }
}
