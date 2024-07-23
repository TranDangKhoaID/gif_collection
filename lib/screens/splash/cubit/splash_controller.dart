import 'package:card_tikimon_collection/common/share_obs.dart';
import 'package:card_tikimon_collection/locator.dart';
import 'package:card_tikimon_collection/routes.dart';
import 'package:card_tikimon_collection/storage/app_preference.dart';
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
    ShareObs.isLoggedIn.value = isLoggedIn;
    if (isLoggedIn) {
      final user = await prefs.getUser();
      ShareObs.user.value = user;
      Get.offAllNamed(AppRoute.accountScreen);
    } else {
      Get.offAllNamed(AppRoute.createCharacterScreen);
    }
  }
}
