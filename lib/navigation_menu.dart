import 'package:tikimon_collection/screens/account/account_screen.dart';
import 'package:tikimon_collection/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tikimon_collection/screens/store/gacha_screen.dart';
import 'package:tikimon_collection/screens/trade/trade_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 70,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (value) =>
              controller.selectedIndex.value = value,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.balance),
              label: 'Giao dịch',
            ),
            NavigationDestination(icon: Icon(Icons.store), label: 'Cửa hàng'),
            NavigationDestination(icon: Icon(Icons.home), label: 'Trang chủ'),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag),
              label: 'Túi đồ',
            ),
            NavigationDestination(icon: Icon(Icons.person), label: 'Hồ sơ'),
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
    Container(color: Colors.yellow),
    const AccountScreen(),
  ];
}
