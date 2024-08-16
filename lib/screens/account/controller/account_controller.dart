import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gif_collection/models/my_tag_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gif_collection/common/share_obs.dart';
import 'package:gif_collection/locator.dart';
import 'package:gif_collection/repositories/firebase_repository.dart';
import 'package:gif_collection/routes.dart';
import 'package:gif_collection/service/database/database_service.dart';
import 'package:gif_collection/service/database/my_tag_db.dart';
import 'package:gif_collection/storage/app_preference.dart';
import 'package:gif_collection/widgets/hub_global_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  /// MARK: - Initials;
  final appPrefs = locator<AppPreference>();
  final firebaseRepository = locator<FirebaseRepository>();

  final myTagDB = MyTagDB();
  //search user data
  RxString sAvatar = ''.obs;
  RxString sName = ''.obs;
  RxInt sCoin = 0.obs;
  RxInt sRuby = 0.obs;
  Rx<List<MyTagModel>> slistMyTags = Rx<List<MyTagModel>>([]);

  /// Logout
  Future<void> logout() async {
    try {
      HudGlobalManager.showHud();
      myTagDB.deleteAll();
      appPrefs.logOut();
      ShareObs.logout();
      Get.offAllNamed(AppRoute.createCharacterScreen);
    } catch (e) {
      debugPrint('Logout error: $e');
    } finally {
      HudGlobalManager.dismissHud();
    }
  }

  Future<void> authLogout() async {
    await firebaseRepository.authLogout();
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<void> addRuby() async {
    ShareObs.ruby.value += 10000;
    await appPrefs.saveRuby(ruby: ShareObs.ruby.value);
  }

  Future<void> addCoin() async {
    ShareObs.coin.value += 1000000;
    await appPrefs.saveCoin(coin: ShareObs.coin.value);
  }

  //delete va create new table
  Future<void> table() async {
    final database = await DatabaseService().database;
    await myTagDB.dropTable();
    await myTagDB.createTable(database);
  }

  Future<void> deleteAllData() async {
    await myTagDB.deleteAll();
  }

  //
  Future<void> saveUserDetail() async {
    EasyLoading.show();
    try {
      firebaseRepository.saveUserDetail(idUser: ShareObs.user.value!.id!);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  Future<void> getUserDetail() async {
    EasyLoading.show();
    try {
      firebaseRepository.getUserDetail(idUser: ShareObs.user.value!.id!);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  Future<void> getSearchUserDetail({
    required String idUserSearch,
  }) async {
    if (idUserSearch.isEmpty) {
      clearValueSearch();
      return;
    }
    EasyLoading.show();
    try {
      firebaseRepository.searchUserDetail(
        idUserSearch: idUserSearch,
        sAvatar: sAvatar,
        sCoin: sCoin,
        sRuby: sRuby,
        sName: sName,
        clearValueSearch: clearValueSearch,
        listTags: slistMyTags,
      );
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  void clearValueSearch() {
    sAvatar.value = '';
    sName.value = '';
    sCoin.value = 0;
    sRuby.value = 0;
    slistMyTags.value = [];
  }
}
