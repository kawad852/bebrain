import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:bebrain/main.dart';
import 'package:bebrain/utils/base_extensions.dart';

class AppOverlayLoader {
  static void show({
    Widget? indicator,
  }) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskType = EasyLoadingMaskType.custom
      ..indicatorColor = Colors.transparent
      ..textColor = Colors.transparent
      ..maskColor = Colors.black26
      ..backgroundColor = Colors.transparent
      ..boxShadow = [];
    EasyLoading.show(indicator: indicator ?? navigatorKey.currentContext!.loaders.circular());
  }

  static bool get isShown => EasyLoading.isShow;

  static void hide() {
    EasyLoading.dismiss();
  }

  static void fakeLoading({
    int duration = 1000,
  }) {
    show();
    Future.delayed(
      Duration(milliseconds: duration),
      () {
        hide();
      },
    );
  }
}
