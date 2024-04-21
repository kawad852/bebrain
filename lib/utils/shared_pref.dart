import 'dart:convert';

import 'package:bebrain/model/auth_model.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late SharedPreferences _sharedPreferences;

  static Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static void clearStorage() {
    MySharedPreferences.accessToken = '';
    user = UserData.fromJson(UserData().toJson());
  }

  static UserData get user {
    String value = _sharedPreferences.getString('userModel') ?? '';
    var authModel = UserData();
    if (value.isNotEmpty) {
      authModel = UserData.fromJson(jsonDecode(value));
    }
    return authModel;
  }

  static set user(UserData value) {
    _sharedPreferences.setString('userModel', jsonEncode(value.toJson()));
  }

  static void saveUser(UserData adminModel) {
    user = UserData.fromJson(adminModel.toJson());
  }

  static String get accessToken => _sharedPreferences.getString('accessToken') ?? '24|KdSh71bdqpHW41M7PQop6vOFHhptFzbw3Xa1abfP201f65ab';
  static set accessToken(String value) => _sharedPreferences.setString('accessToken', value);

  static String get language => _sharedPreferences.getString('language') ?? LanguageEnum.english;
  static set language(String value) => _sharedPreferences.setString('language', value);

  static String get theme => _sharedPreferences.getString('theme') ?? ThemeEnum.light;
  static set theme(String value) => _sharedPreferences.setString('theme', value);

  static bool get isPassedIntro => _sharedPreferences.getBool('isPassedIntro') ?? false;
  static set isPassedIntro(bool value) => _sharedPreferences.setBool('isPassedIntro', value);
}
