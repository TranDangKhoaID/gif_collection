import 'package:card_tikimon_collection/common/share_colors.dart';
import 'package:card_tikimon_collection/common/share_obs.dart';
import 'package:card_tikimon_collection/widgets/money_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppBarGlobal extends StatelessWidget implements PreferredSizeWidget {
  const AppBarGlobal({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: MoneyAppBarWidget(
              icon: Icons.diamond,
              money: ShareObs.ruby.value,
              color: ShareColors.kColorRuby,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: MoneyAppBarWidget(
              icon: Icons.money,
              money: ShareObs.cash.value,
              color: ShareColors.kColorCash,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
