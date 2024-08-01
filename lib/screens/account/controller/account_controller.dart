import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tikimon_collection/common/share_obs.dart';
import 'package:tikimon_collection/locator.dart';
import 'package:tikimon_collection/models/user_model.dart';
import 'package:tikimon_collection/routes.dart';
import 'package:tikimon_collection/storage/app_preference.dart';
import 'package:tikimon_collection/widgets/hub_global_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  /// MARK: - Initials;
  final appPrefs = locator<AppPreference>();
  //UserModel user = UserModel();

  /// Logout
  Future<void> logout() async {
    try {
      HudGlobalManager.showHud();
      Get.back();
      authLogout();
      ShareObs.logout();
      await appPrefs.logOut();
      Get.offAllNamed(AppRoute.signInScreen);
    } catch (e) {
      debugPrint('Logout error: $e');
    } finally {
      HudGlobalManager.dismissHud();
    }
  }

  Future<void> authLogout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<void> addRuby() async {
    ShareObs.ruby.value += 100;
    await appPrefs.saveRuby(ruby: ShareObs.ruby.value);
  }

  Future<void> addCoin() async {
    ShareObs.coin.value += 100000;
    await appPrefs.saveCoin(coin: ShareObs.coin.value);
  }
}
