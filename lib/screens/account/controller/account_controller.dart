import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tikimon_collection/common/share_obs.dart';
import 'package:tikimon_collection/locator.dart';
import 'package:tikimon_collection/models/user_model.dart';
import 'package:tikimon_collection/routes.dart';
import 'package:tikimon_collection/service/database/my_tag_db.dart';
import 'package:tikimon_collection/storage/app_preference.dart';
import 'package:tikimon_collection/widgets/hub_global_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  /// MARK: - Initials;
  final appPrefs = locator<AppPreference>();
  //UserModel user = UserModel();
  final myTagDB = MyTagDB();

  /// Logout
  Future<void> logout() async {
    try {
      HudGlobalManager.showHud();
      Get.back();
      authLogout();
      ShareObs.logout();
      await appPrefs.logOut();
      await deletAllMyTags();
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

  //delete all my tags
  Future<void> deletAllMyTags() async {
    await myTagDB.deleteAll();
  }

  //
  Future<void> saveUserDetail() async {
    String idUser = ShareObs.user.value!.id!;
    EasyLoading.show();
    await FirebaseFirestore.instance.collection('users').doc(idUser).set({
      'id': idUser,
      'name': ShareObs.user.value!.name,
      'email': ShareObs.user.value!.email,
      'photoUrl': ShareObs.user.value?.photoUrl ?? '',
      'ruby': ShareObs.ruby.value,
      'coin': ShareObs.coin.value,
      'moneyCoin': ShareObs.moneyCoin.value,
      'avatar': ShareObs.avatarUser.value,
      'updateAt': DateTime.now(),
    }).catchError((e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e);
    });
    EasyLoading.showSuccess('Thành công');
    EasyLoading.dismiss();
  }

  Future<void> getUserDetail() async {
    try {
      String idUser = ShareObs.user.value!.id!;
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(idUser)
          .get();
      if (!doc.exists) {
        EasyLoading.dismiss();
        EasyLoading.showError('Bạn chưa lưu tài khoản trước đó');
        return;
      }
      final coin = doc['coin'];
      final ruby = doc['ruby'];
      final moneyCoin = doc['moneyCoin'];
      final avatar = doc['avatar'];
      await appPrefs.saveAvatarUser(avatar: avatar);
      await appPrefs.saveCoin(coin: coin);
      await appPrefs.saveRuby(ruby: ruby);
      await appPrefs.saveMoneyCoin(mCoin: moneyCoin);
      ShareObs.ruby.value = ruby;
      ShareObs.coin.value = await coin;
      ShareObs.moneyCoin.value = await moneyCoin;
      ShareObs.avatarUser.value = await avatar;
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Thành công');
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }
}
