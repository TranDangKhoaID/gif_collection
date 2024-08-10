import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_collection/common/share_colors.dart';
import 'package:gif_collection/common/share_obs.dart';
import 'package:gif_collection/extensions/string.dart';
import 'package:gif_collection/widgets/money_app_bar_widget.dart';

class HeaderCurrency extends StatelessWidget {
  const HeaderCurrency({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                onTap: () {
                  Get.dialog(
                    barrierDismissible: false,
                    Container(
                      height: size.height * 0.7,
                      width: size.height * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/wood.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildRewardVideo(),
                          _buildValue(
                            assets: 'assets/images/icons/ruby.png',
                            value: 100,
                            btnValue: 19000,
                            onPressed: () {},
                          ),
                          _buildValue(
                            assets: 'assets/images/icons/ruby.png',
                            value: 200,
                            btnValue: 39000,
                            onPressed: () {},
                          ),
                          _buildValue(
                            assets: 'assets/images/icons/ruby.png',
                            value: 1000,
                            btnValue: 149000,
                            onPressed: () {},
                          ),
                          _buildValue(
                            assets: 'assets/images/icons/ruby.png',
                            value: 35000,
                            btnValue: 499000,
                            onPressed: () {},
                          ),
                          _buildValue(
                            assets: 'assets/images/icons/ruby.png',
                            value: 10000,
                            btnValue: 1400000,
                            onPressed: () {},
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              backgroundColor: ShareColors.kPrimaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ), // Radius 10
                              ),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('close'.tr),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: MoneyAppBarWidget(
                icon: Icons.monetization_on,
                money: ShareObs.coin.value,
                color: ShareColors.kColorCoin,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValue(
      {required String assets,
      required int value,
      required int btnValue,
      required void Function() onPressed}) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            width: 20,
            assets,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Text(
            value.toString(),
            style: TextStyle(
              color: ShareColors.kPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(10),
              backgroundColor: ShareColors.kPrimaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Radius 10
              ),
            ),
            onPressed: onPressed,
            child: Text(formattedNumberCurrency(btnValue)),
          )
        ],
      ),
    );
  }

  Widget _buildRewardVideo() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            width: 20,
            'assets/images/icons/ruby.png',
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Text(
            'x10',
            style: TextStyle(
              color: ShareColors.kPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          TextButton.icon(
            icon: const Icon(Icons.play_circle_filled),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(10),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Radius 10
              ),
            ),
            onPressed: () {},
            label: const Text("Nhận ngay"),
          )
        ],
      ),
    );
  }
}
