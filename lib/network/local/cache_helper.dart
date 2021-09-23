import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  ///init the sharedPreferences
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  ///sharedPreferences set function
  static Future<bool> putData(
      {required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  ///sharedPreferences get function
  static bool? getData({required String key}) {
    return sharedPreferences.getBool(key);
  }
}
