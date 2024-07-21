import 'package:card_tikimon_collection/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onGenerateRoute: AppRoute.generateRoute,
      navigatorKey: Get.key,
      initialRoute: AppRoute.splashScreen,
    );
  }
}
