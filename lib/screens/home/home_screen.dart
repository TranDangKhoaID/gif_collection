import 'package:tikimon_collection/common/share_colors.dart';
import 'package:tikimon_collection/common/share_obs.dart';
import 'package:tikimon_collection/extensions/string.dart';
import 'package:tikimon_collection/models/user_model.dart';
import 'package:tikimon_collection/screens/home/controller/home_controller.dart';
import 'package:tikimon_collection/storage/app_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tikimon_collection/widgets/money_app_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Obx(() => _buildHeaderCurrency()),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
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
                    Text('Vàng'),
                    SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => Text(
                        formattedNumber(ShareObs.coin.value),
                        style: TextStyle(
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
                            _controller.upgradeMoneyCoin();
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ShareColors.kPrimaryColor,
                            ),
                            child: Column(
                              children: [
                                Text('Nâng cấp'),
                                Row(
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
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            Text('Chạm vào cây để hái vàng'),
                            Text('Giá trị mỗi lần hái'),
                            Obx(
                              () => Text(
                                ShareObs.moneyCoin.value.toString(),
                                style: TextStyle(
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

  Widget _buildHeaderCurrency() {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, top: 30),
      child: Row(
        children: [
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
              icon: Icons.monetization_on,
              money: ShareObs.coin.value,
              color: ShareColors.kColorCoin,
            ),
          ),
        ],
      ),
    );
  }
}
