import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/cupertino.dart';

class ValidationHelper {
  static final emailRegex = RegExp(r"^[a-zA-Z\d.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z\d](?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?(?:\.[a-zA-Z\d](?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?)*$");
  static final decimalNumbersRegex = RegExp(r'^\d*\.?\d*$');
  static final intNumberRegex = RegExp(r'^\d+$');

  static String? general(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.appLocalization.requiredField;
    }
    return null;
  }

  static String? email(BuildContext context, String? value) {
    if (value!.isEmpty) {
      return context.appLocalization.requiredField;
    } else if (!emailRegex.hasMatch(value)) {
      return context.appLocalization.invalidEmail;
    }
    return null;
  }

  static String? numbers(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.appLocalization.requiredField;
    } else if (!decimalNumbersRegex.hasMatch(value)) {
      return context.appLocalization.invalidNumber;
    }
    return null;
  }

  static String? numberInt(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.appLocalization.requiredField;
    } else if (!intNumberRegex.hasMatch(value)) {
      return context.appLocalization.invalidNumber;
    }
    return null;
  }

  // static String? password(BuildContext context, String? value) {
  //   if (value!.isEmpty) {
  //     return context.appLocalization.requiredField;
  //   } else if (value.length < 6) {
  //     return context.appLocalization.passwordTooShort;
  //   }
  //
  //   return null;
  // }
}
