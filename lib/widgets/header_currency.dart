import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tikimon_collection/common/share_colors.dart';
import 'package:tikimon_collection/common/share_obs.dart';
import 'package:tikimon_collection/widgets/money_app_bar_widget.dart';

class HeaderCurrency extends StatelessWidget {
  const HeaderCurrency({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Obx(
        () => Row(
          children: [
            Expanded(
              flex: 1,
              child: MoneyAppBarWidget(
                icon: Icons.diamond,
                money: ShareObs.ruby.value,
                color: ShareColors.kColorRuby,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: MoneyAppBarWidget(
                icon: Icons.monetization_on,
                money: ShareObs.coin.value,
                color: ShareColors.kColorCoin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
