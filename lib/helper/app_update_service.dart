import 'dart:async';
import 'dart:io' show Platform;

import 'package:bebrain/helper/screenshot_service.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class AppUpdateService {
  Future<void> fetchVersionAndUpdateApp() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await remoteConfig.fetchAndActivate();
      final minSupportedVersion = remoteConfig.getString('minimum_supported_version');
      ScreenShotService.canScreenshot = remoteConfig.getBool('can_screenshot');
      debugPrint("minSupportedVersion:: $minSupportedVersion");
      final isLowerVersion = _isVersionLower(currentVersion, minSupportedVersion);
      if (isLowerVersion) {
        _showUpdateDialog();
      }
    } catch (e) {
      debugPrint("error:: $e");
    }
  }

  bool _isVersionLower(String current, String min) {
    List<int> currentParts = current.split('.').map(int.parse).toList();
    List<int> minParts = min.split('.').map(int.parse).toList();

    for (int i = 0; i < minParts.length; i++) {
      if (currentParts[i] < minParts[i]) return true;
      if (currentParts[i] > minParts[i]) return false;
    }
    return false;
  }

  Future<void> _showUpdateDialog() async {
    return showDialog<void>(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: Text(context.appLocalization.updateRequired),
            content: Text(context.appLocalization.updateBody),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  const appId = "com.almusaed.wecan";
                  final appStoreUrl = Uri.parse(
                    Platform.isAndroid ? "market://details?id=$appId" : "https://apps.apple.com/app/id6599861567",
                  );
                  if (await canLaunchUrl(appStoreUrl)) {
                    await launchUrl(appStoreUrl);
                  } else {
                    throw 'Could not launch $appStoreUrl';
                  }
                },
                child: Text(context.appLocalization.update),
              ),
            ],
          ),
        );
      },
    );
  }
}
