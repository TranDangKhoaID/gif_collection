import 'dart:async';

import 'package:card_tikimon_collection/common/share_obs.dart';
import 'package:card_tikimon_collection/locator.dart';
import 'package:card_tikimon_collection/models/user_model.dart';
import 'package:card_tikimon_collection/routes.dart';
import 'package:card_tikimon_collection/storage/app_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  /// MARK: - Initials;
  final appPrefs = locator<AppPreference>();
  UserModel user = UserModel();

  /// Logout
  Future<void> logout() async {
    try {
      Get.back();
      ShareObs.logout();
      await appPrefs.logOut();
      Get.offAllNamed(AppRoute.createCharacterScreen);
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }
}
