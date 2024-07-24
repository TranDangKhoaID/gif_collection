import 'package:tikimon_collection/common/share_obs.dart';
import 'package:tikimon_collection/locator.dart';
import 'package:tikimon_collection/models/user_model.dart';
import 'package:tikimon_collection/routes.dart';
import 'package:tikimon_collection/storage/app_preference.dart';
import 'package:tikimon_collection/widgets/hub_global_widget.dart';
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
        name: name,
      );
      await appPrefs.saveUser(userModel: userModel);
      final user = await appPrefs.getUser();
      ShareObs.ruby.value = await appPrefs.getRuby();
      ShareObs.coin.value = await appPrefs.getCoin();
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
