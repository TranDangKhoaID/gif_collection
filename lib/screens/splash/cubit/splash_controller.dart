import 'package:tikimon_collection/common/share_obs.dart';
import 'package:tikimon_collection/locator.dart';
import 'package:tikimon_collection/routes.dart';
import 'package:tikimon_collection/storage/app_preference.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final prefs = locator<AppPreference>();
  @override
  void onReady() {
    super.onReady();
    checkLogged();
  }

  Future<void> checkLogged() async {
    final isLoggedIn = await prefs.isLoggedIn();
    ShareObs.ruby.value = await prefs.getRuby();
    ShareObs.coin.value = await prefs.getCoin();
    ShareObs.isLoggedIn.value = isLoggedIn;
    if (isLoggedIn) {
      final user = await prefs.getUser();
      ShareObs.user.value = user;
      Get.offAllNamed(AppRoute.navigationMenu);
    } else {
      Get.offAllNamed(AppRoute.createCharacterScreen);
    }
  }
}
