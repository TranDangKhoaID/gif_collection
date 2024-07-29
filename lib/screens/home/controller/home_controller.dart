import 'dart:async';

import 'package:tikimon_collection/common/share_obs.dart';
import 'package:tikimon_collection/locator.dart';
import 'package:tikimon_collection/models/user_model.dart';
import 'package:tikimon_collection/routes.dart';
import 'package:tikimon_collection/storage/app_preference.dart';
import 'package:tikimon_collection/widgets/hub_global_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  /// MARK: - Initials;
  final appPrefs = locator<AppPreference>();
  //UserModel user = UserModel();

  Future<void> addCoin() async {
    ShareObs.coin.value += ShareObs.moneyCoin.value;
    await appPrefs.saveCoin(coin: ShareObs.coin.value);
  }
}
