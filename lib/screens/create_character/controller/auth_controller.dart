import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gif_collection/common/share_obs.dart';
import 'package:gif_collection/locator.dart';
import 'package:gif_collection/models/user_model.dart';
import 'package:gif_collection/routes.dart';
import 'package:gif_collection/storage/app_preference.dart';
import 'package:gif_collection/widgets/hub_global_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final appPrefs = locator<AppPreference>();

  final googleSignIn = GoogleSignIn();
  //GoogleSignInAccount? _user;
  //GoogleSignInAccount get user => _user!;

  Future<void> signUp({
    required String url,
    required String name,
  }) async {
    try {
      HudGlobalManager.showHud();
      final userModel = UserModel(
        photoUrl: url,
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

  //google sign in
  Future<void> signInWithGoogle(String url) async {
    try {
      //google sign in
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      //save local
      final userModel = UserModel(
        photoUrl: googleUser.photoUrl,
        id: userCredential.user!.uid,
        name: googleUser.displayName,
        email: googleUser.email,
      );
      await appPrefs.saveUser(userModel: userModel);
      final user = await appPrefs.getUser();
      ShareObs.user.value = user;
      //avatar user
      ShareObs.avatarUser.value = url;
      await appPrefs.saveAvatarUser(avatar: url);
      await appPrefs.saveCoin(coin: ShareObs.coin.value);
      await appPrefs.saveRuby(ruby: ShareObs.ruby.value);
      await appPrefs.saveMoneyCoin(mCoin: ShareObs.moneyCoin.value);
      ShareObs.isLoggedIn.value = true;
      Get.offAllNamed(AppRoute.navigationMenu);
    } catch (e) {
      debugPrint('Sign up error: $e');
    }
  }
}
