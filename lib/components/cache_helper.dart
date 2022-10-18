import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences preferences;

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required String key,
    required bool value,
  }) async {
    return await preferences.setBool(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return preferences.get(key);
  }
}
