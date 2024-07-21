import 'package:card_tikimon_collection/common/share_obs.dart';
import 'package:card_tikimon_collection/locator.dart';
import 'package:card_tikimon_collection/models/user_model.dart';
import 'package:card_tikimon_collection/routes.dart';
import 'package:card_tikimon_collection/storage/app_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final appPrefs = locator<AppPreference>();

  Future<void> signUp({
    String? url,
    String? name,
  }) async {
    try {
      final user = UserModel(
        avatar: url,
        id: '000001',
        cash: 0,
        ruby: 0,
        name: name,
        treeCashLevel: 10000,
      );
      await appPrefs.saveUser(userModel: user);
      ShareObs.isLoggedIn.value = true;
      Get.offAllNamed(AppRoute.homeScreen);
    } catch (e) {
      debugPrint('Sign up error: $e');
    }
  }
}
