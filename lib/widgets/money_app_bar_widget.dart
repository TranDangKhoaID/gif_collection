import 'package:gif_collection/common/share_colors.dart';
import 'package:flutter/material.dart';
import 'package:gif_collection/extensions/string.dart';

class MoneyAppBarWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final int money;
  final void Function() onTap;

  const MoneyAppBarWidget({
    super.key,
    required this.color,
    required this.icon,
    required this.money,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: color,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                formattedNumber(money),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 1),
            padding: const EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                '+',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
