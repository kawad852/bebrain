import 'package:bebrain/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:no_screenshot/no_screenshot.dart';

class ScreenShotService {
  static final _noScreenshot = NoScreenshot.instance;
  static bool canScreenshot = MySharedPreferences.canScreenshot;

  static void disableScreenshot() async {
    if (!canScreenshot) {
      bool result = await _noScreenshot.screenshotOff();
      debugPrint('Screenshot Off: $result');
    }
  }

  static void enableScreenshot() async {
    if (!canScreenshot) {
      bool result = await _noScreenshot.screenshotOn();
      debugPrint('Enable Screenshot: $result');
    }
  }
}
