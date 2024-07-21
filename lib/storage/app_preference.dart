import 'package:card_tikimon_collection/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class AppPreference {
  /// Save user
  Future<void> saveUser({
    required UserModel userModel,
  }) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(AppPreferenceKey.kUser, userModel.toRawJson());
  }

  /// Get user
  Future<UserModel?> getUser() async {
    final pref = await SharedPreferences.getInstance();
    final jsonStr = pref.getString(AppPreferenceKey.kUser);
    if (jsonStr == null || jsonStr.isEmpty) {
      return null;
    }
    return UserModel.fromRawJson(jsonStr);
  }

  /// Check is logged in
  Future<bool> isLoggedIn() async {
    final user = await getUser();
    return user != null;
  }

  /// Logout
  Future<void> logOut() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(AppPreferenceKey.kUser);
  }
}

class AppPreferenceKey {
  static const String kConfigs = 'configs';
  static const String kUser = 'user';
  static const String kFirstRun = 'first_run';
  static const String kDomain = 'domain';
  static const String kCustomerInfo = 'customer_info';
  static const String kEnablePushNotify = 'enable_push_notify';
  static const String kWishProduct = 'wish_product';
  static const String kCartProduct = 'cart_product';
  static const String kDiscount = 'discount';
  static const String kVoucherCode = 'voucher_code';
}
