import 'package:tikimon_collection/models/user_model.dart';
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

  //ruby and coin
  Future<void> saveRuby({
    required int ruby,
  }) async {
    final pref = await SharedPreferences.getInstance();
    pref.setInt(AppPreferenceKey.kRuby, ruby);
  }

  Future<int> getRuby() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt(AppPreferenceKey.kRuby) ?? 0;
  }

  Future<void> saveCoin({
    required int coin,
  }) async {
    final pref = await SharedPreferences.getInstance();
    pref.setInt(AppPreferenceKey.kCoin, coin);
  }

  Future<int> getCoin() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt(AppPreferenceKey.kCoin) ?? 0;
  }

  //money three
  Future<void> saveMoneyCoin({
    required int mCoin,
  }) async {
    final pref = await SharedPreferences.getInstance();
    pref.setInt(AppPreferenceKey.kMoneyCoin, mCoin);
  }

  Future<int> getMoneyCoin() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt(AppPreferenceKey.kMoneyCoin) ?? 0;
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
    pref.remove(AppPreferenceKey.kRuby);
    pref.remove(AppPreferenceKey.kCoin);
  }
}

class AppPreferenceKey {
  static const String kUser = 'user';
  static const String kRuby = 'ruby';
  static const String kCoin = 'coin';
  static const String kMoneyCoin = 'money_coin';
  static const String kFirstRun = 'first_run';
  static const String kDomain = 'domain';
  static const String kCustomerInfo = 'customer_info';
  static const String kEnablePushNotify = 'enable_push_notify';
  static const String kWishProduct = 'wish_product';
  static const String kCartProduct = 'cart_product';
  static const String kDiscount = 'discount';
  static const String kVoucherCode = 'voucher_code';
}
