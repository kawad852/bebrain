import 'package:bebrain/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';

class AppProvider extends ChangeNotifier {
  Locale appLocale = Locale(MySharedPreferences.language);
  String appTheme = MySharedPreferences.theme;

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
}
