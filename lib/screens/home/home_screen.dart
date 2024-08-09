import 'package:gif_collection/common/share_colors.dart';
import 'package:gif_collection/common/share_obs.dart';
import 'package:gif_collection/extensions/string.dart';
import 'package:gif_collection/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_collection/widgets/header_currency.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _hasTapped = false;
  final _controller = Get.put(HomeController());
  //

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: size.height * 0.45,
              child: Image.asset(
                'assets/images/bg_home.png',
                fit: BoxFit.cover,
              ),
            ),
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: HeaderCurrency(),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      offset: const Offset(4, 4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4, -4),
                      blurRadius: 10,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                width: 250,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('coin'.tr),
                    const SizedBox(height: 5),
                    Obx(
                      () => Text(
                        formattedNumber(ShareObs.coin.value),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.5,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _controller.startCountdown();
                          },
                          child: Obx(
                            () => _controller.isCountingDown.value
                                ? Center(
                                    child: Text(
                                      '${_controller.countdown.value}',
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: ShareColors.kPrimaryColor,
                                    ),
                                    child: Column(
                                      children: [
                                        Text('upgrade'.tr),
                                        const Row(
                                          children: [
                                            Icon(
                                              Icons.diamond,
                                              color: Colors.red,
                                            ),
                                            Text('3'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            Text('tap_the_tree_to_pick_gold'.tr),
                            Text('value_per_pick'.tr),
                            Obx(
                              () => Text(
                                formattedNumber(ShareObs.moneyCoin.value),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        _controller.addCoin();
                      },
                      child: Image.asset(
                        width: 200,
                        'assets/images/money_three.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
