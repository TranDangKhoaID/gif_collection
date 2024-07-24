import 'package:card_tikimon_collection/common/share_obs.dart';
import 'package:card_tikimon_collection/locator.dart';
import 'package:card_tikimon_collection/models/user_model.dart';
import 'package:card_tikimon_collection/routes.dart';
import 'package:card_tikimon_collection/storage/app_preference.dart';
import 'package:card_tikimon_collection/widgets/hub_global_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final appPrefs = locator<AppPreference>();

  Future<void> signUp({
    required String url,
    required String name,
  }) async {
    try {
      HudGlobalManager.showHud();
      final userModel = UserModel(
        avatar: url,
        id: '000001',
        cash: 0,
        ruby: 0,
        name: name,
        treeCashLevel: 10000,
      );
      await appPrefs.saveUser(userModel: userModel);
      final user = await appPrefs.getUser();
      ShareObs.user.value = user;
      ShareObs.isLoggedIn.value = true;
      Get.offAllNamed(AppRoute.navigationMenu);
    } catch (e) {
      debugPrint('Sign up error: $e');
    } finally {
      HudGlobalManager.dismissHud();
    }
  }
}
