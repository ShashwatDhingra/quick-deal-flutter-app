import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String token = 'TOKEN';

  static SharedPreferences? _pref;

  static final PrefHelper _instance = PrefHelper._privateConstructor();

  // Add a static flag to ensure initialization only happens once
  static bool _initialized = false;

  PrefHelper._privateConstructor() {
    if (!_initialized) {
      throw Exception('Call initSharedPref() before using PrefHelper');
    }
  }

  factory PrefHelper() {
    return _instance;
  }

  static Future<void> initSharedPref() async {
    if (!_initialized) {
      _pref = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  static Future<bool> setString(String key, String value) async {
    return await _pref!.setString(key, value);
  }

  static String? getString(String key) {
    if (_pref!.containsKey(key)) {
      return _pref!.getString(key)!;
    } else {
      return null;
    }
  }

  static Future<bool> setBool(String key, bool value) async {
    return _pref!.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _pref!.getBool(key);
  }

  static Future<bool> clearRecord(String key) async {
    return await _pref!.remove(PrefHelper.token);
  }
}

class AuthPrefHelper {
  static Future<bool> saveUserToken(String token) async {
    return PrefHelper.setString(PrefHelper.token, token);
  }

  static Future<String?> getUserToken() async {
    return PrefHelper.getString(PrefHelper.token) ?? null;
  }

  static Future<bool> isUserLogin() async {
    final token = PrefHelper.getString(PrefHelper.token);
    return (token == null || token.isEmpty) ? false : true;
  }

  static Future<bool> clearToken() async {
    return PrefHelper.clearRecord(PrefHelper.token);
  }
}
