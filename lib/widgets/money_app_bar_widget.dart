import 'package:tikimon_collection/common/share_colors.dart';
import 'package:flutter/material.dart';

class MoneyAppBarWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final int money;

  const MoneyAppBarWidget({
    super.key,
    required this.color,
    required this.icon,
    required this.money,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
                money.toString(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 1),
            padding: EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Text(
              '+',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
