import 'package:bebrain/model/countries_model.dart';
import 'package:bebrain/utils/app_constants.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/countries.dart';
import 'package:flutter/material.dart';

class PhoneController extends ChangeNotifier {
  String? countryCode;
  String? phoneNum;

  PhoneController(
    BuildContext context, {
    String? countryCode,
    String? phoneNum,
  }) {
    _init(context, countryCode: countryCode, phoneNum: phoneNum);
  }

  void _init(
    BuildContext context, {
    required String? countryCode,
    required String? phoneNum,
  }) {
    this.countryCode = countryCode ?? context.countryCode ?? kFallBackCountryCode;
    this.phoneNum = phoneNum;
  }

  String getDialCode() => kCountries.singleWhere((element) => element.code == countryCode, orElse: () => CountryModel(code: kFallBackCountryCode)).dialCode!;
}
