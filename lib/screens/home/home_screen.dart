import 'package:card_tikimon_collection/common/share_obs.dart';
import 'package:card_tikimon_collection/models/user_model.dart';
import 'package:card_tikimon_collection/screens/home/controller/home_controller.dart';
import 'package:card_tikimon_collection/storage/app_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(ShareObs.user.value?.name ?? ''),
          Text(ShareObs.user.value?.avatar ?? 'Null ?'),
        ],
      ),
    );
  }
}
