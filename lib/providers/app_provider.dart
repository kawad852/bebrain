import 'dart:convert';

import 'package:bebrain/model/country_code_model.dart';
import 'package:bebrain/utils/app_constants.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AppProvider extends ChangeNotifier {
  Locale appLocale = Locale(MySharedPreferences.language);
  String appTheme = MySharedPreferences.theme;
  static String countryCode = MySharedPreferences.countryCode;

  void changeLanguage(
    BuildContext context, {
    required String languageCode,
  }) async {
    MySharedPreferences.language = languageCode;
    appLocale = Locale(languageCode);
    notifyListeners();
  }

  void changeTheme(
    BuildContext context, {
    required String theme,
  }) async {
    MySharedPreferences.theme = theme;
    appTheme = theme;
    notifyListeners();
  }

  static Future<void> getCountryCode() async {
    try {
      final response = await http.get(Uri.https('api.country.is'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final countryCodeModel = CountryCodeModel.fromJson(body);
        countryCode = countryCodeModel.countryCode ?? kFallBackCountryCode;
      } else {
        countryCode = kFallBackCountryCode;
      }
    } catch (e) {
      countryCode = kFallBackCountryCode;
    } finally {
      debugPrint('countryCode:: $countryCode');
    }
  }
}
