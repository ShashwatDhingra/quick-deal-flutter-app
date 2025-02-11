import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String isSyncEnabled = 'is_sync_enabled';

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

  Future<bool> setString(String key, String value) async {
    return await _pref!.setString(key, value);
  }

  String? getString(String key) {
    if (_pref!.containsKey(key)) {
      return _pref!.getString(key)!;
    } else {
      return null;
    }
  }

  Future<bool> setBool(String key, bool value) async {
    return _pref!.setBool(key, value);
  }

  bool? getBool(String key) {
    return _pref!.getBool(key);
  }

  Future<bool> getSyncToCloudPreference() async {
    return getBool(PrefHelper.isSyncEnabled) ?? false;
  }

  Future<void> setSyncToCloudPreference(bool value) async {
    setBool(PrefHelper.isSyncEnabled, value);
  }
}
