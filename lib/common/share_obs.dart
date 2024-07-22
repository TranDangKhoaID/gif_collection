import 'package:card_tikimon_collection/models/user_model.dart';
import 'package:get/get.dart';

class ShareObs {
  static final RxString urlCharacter = ''.obs;
  static final RxInt wishes = 0.obs;
  static final RxInt notify = 0.obs;
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
    ShareObs.notify.value = 0;
    ShareObs.urlCharacter.value = '';
    ShareObs.wishes.value = 0;
  }
}
