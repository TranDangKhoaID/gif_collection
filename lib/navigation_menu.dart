import 'package:gif_collection/screens/account/account_screen.dart';
import 'package:gif_collection/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_collection/screens/my_bag/my_bag_screen.dart';
import 'package:gif_collection/screens/store/gacha_screen.dart';
import 'package:gif_collection/screens/trade/trade_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Nhiệm vụ',
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   onPressed: () {},
      //   child: Image.asset(
      //     'assets/images/missions.png',
      //     fit: BoxFit.cover,
      //   ),
      // ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 70,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (value) =>
              controller.selectedIndex.value = value,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.balance),
              label: 'trade'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.store),
              label: 'shop'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.home),
              label: 'earnings'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.shopping_bag),
              label: 'bag'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person),
              label: 'profile'.tr,
            ),
          ],
        ),
      ),
      body: Obx(
        () => controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 2.obs;
  final screens = [
    const TradeScreen(),
    const GachaScreen(),
    const HomeScreen(),
    const MyBagScreen(),
    const AccountScreen(),
  ];
}
