import 'package:tikimon_collection/models/user_model.dart';
import 'package:get/get.dart';

class ShareObs {
  static final RxString urlCharacter = ''.obs;
  static final RxInt ruby = 100.obs;
  static final RxInt coin = 10000.obs;
  static final RxInt myVoucher = 0.obs;
  static final RxBool isLoggedIn = false.obs;
  static final RxBool isFBconnected = false.obs;
  static final RxBool isEnablePushNotify = true.obs;
  static RxBool isShowHUDGlobal = false.obs;
  static RxBool isEnableGesture = true.obs;
  static Rx<UserModel?> user = Rx<UserModel?>(null);

  /// Logout
  static void logout() async {
    ShareObs.isLoggedIn.value = false;
    ShareObs.isFBconnected.value = false;
    ShareObs.myVoucher.value = 0;
    ShareObs.user.value = null;
    ShareObs.ruby.value = 100;
    ShareObs.urlCharacter.value = '';
    ShareObs.coin.value = 10000;
  }
}
