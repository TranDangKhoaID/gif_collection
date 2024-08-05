import 'dart:async';

import 'package:get/get_rx/get_rx.dart';
import 'package:gif_collection/common/share_obs.dart';
import 'package:gif_collection/locator.dart';
import 'package:gif_collection/models/user_model.dart';
import 'package:gif_collection/routes.dart';
import 'package:gif_collection/storage/app_preference.dart';
import 'package:gif_collection/widgets/hub_global_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  /// MARK: - Initials;
  final appPrefs = locator<AppPreference>();
  RxInt coin = ShareObs.coin;
  RxInt ruby = ShareObs.ruby;
  RxInt moneyCoin = ShareObs.moneyCoin;

  Future<void> addCoin() async {
    coin.value += moneyCoin.value;
    await appPrefs.saveCoin(coin: coin.value);
  }

  Future<void> upgradeMoneyCoin() async {
    if (ruby.value < 3) {
      print('Ko du ruby');
      return;
    }
    moneyCoin.value += 2610;
    ruby.value = ruby.value - 3;
    await appPrefs.saveRuby(ruby: ruby.value);
    await appPrefs.saveMoneyCoin(mCoin: moneyCoin.value);
  }
}
