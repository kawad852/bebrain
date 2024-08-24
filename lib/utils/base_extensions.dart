import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/alerts/loading/app_loading_indicators.dart';
import 'package:bebrain/network/api_url.dart';
import 'package:bebrain/providers/app_provider.dart';
import 'package:bebrain/providers/auth_provider.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/providers/payment_provider.dart';
import 'package:bebrain/utils/app_routes.dart';
import 'package:bebrain/utils/color_palette.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

extension LanguageExtension on BuildContext {
  AppLocalizations get appLocalization => AppLocalizations.of(this)!;

  String get languageCode => Localizations.localeOf(this).languageCode;

  bool get isLTR => Localizations.localeOf(this).languageCode == LanguageEnum.english;

  String translate({
    required String textEN,
    required String textAR,
  }) {
    return isLTR ? textEN : textAR;
  }
}

extension MediaQueryExtension on BuildContext {
  Size get mediaQuery => MediaQuery.sizeOf(this);
}

extension NavigatorExtension on BuildContext {
  Future<dynamic> push(Widget screen) async {
    final routeName = AppRoutes.names[screen.runtimeType];
    final value = await Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
        settings: RouteSettings(name: routeName),
      ),
    );
    return value;
  }

  void pushReplacement(
    Widget screen, {
    Function(dynamic value)? then,
  }) async {
    final routeName = AppRoutes.names[screen.runtimeType];
    final value = await Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
        settings: RouteSettings(name: routeName),
      ),
    );
    if (then != null) {
      then(value);
    }
  }

  Future<void> pushAndRemoveUntil(Widget screen) async{
    final routeName = AppRoutes.names[screen.runtimeType];
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
        settings: RouteSettings(name: routeName),
      ),
      (route) => false,
    );
  }

  void pop([value]) => Navigator.pop(this, value);
}

extension AppLoadingIncidatorExtension on BuildContext {
  AppLoadingIndicator get loaders => AppLoadingIndicator.of(this);
}

extension ThemeExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  ColorPalette get colorPalette => ColorPalette.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension ProvidersExtension on BuildContext {
  AuthProvider get authProvider => read<AuthProvider>();
  AppProvider get appProvider => read<AppProvider>();
  MainProvider get mainProvider => read<MainProvider>();
  PaymentProvider get paymentProvider => read<PaymentProvider>();
}

extension CommonExtensions on BuildContext {
  void unFocusKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
  double get systemButtonHeight => Theme.of(this).buttonTheme.height;
  String? get currentRouteName => ModalRoute.of(this)?.settings.name;
  String? get countryCode => AppProvider.countryCode;
}

extension ImageExtension on BuildContext {
  String image(String url) {
    return '${ApiUrl.mainUrl}/$url';
  }
}

extension DateExtension on String {
  String formatDate(
    BuildContext context, {
    String pattern = 'dd-MM-yyyy',
  }) {
    final date = DateTime.parse(this);
    var formattedDate = DateFormat(pattern, Localizations.localeOf(context).languageCode).format(date);
    return formattedDate;
  }
}

extension DateTimeExtension on DateTime {
  String formatDate(
    BuildContext context, {
    String pattern = 'dd-MM-yyyy',
    bool withLocale = true,
  }) {
    var date = DateFormat(pattern, withLocale ? context.languageCode : null).format(this);
    return date;
  }
}

extension UTCDate on DateTime {
  DateTime toUTC(BuildContext context){
    final utcTime = DateTime.utc(year, month, day, hour, minute, second);
    return utcTime.toLocal();
  }
}

extension CustomDialog on BuildContext{
  Future dialogNotAvailble(){
    return this.showDialog(
      titleText: appLocalization.unavailable,
      bodyText: appLocalization.expiredPeriodCourse,
      confirmTitle: appLocalization.back,
    );
  }
} 

