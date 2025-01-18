import 'dart:developer';
import 'dart:io';

import 'package:bebrain/main.dart';
import 'package:bebrain/notifications/local_notifications_service.dart';
import 'package:bebrain/notifications/notifications_routes_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../utils/shared_pref.dart';

class CloudMessagingService {
  void requestPermission() async {
    await FirebaseMessaging.instance.requestPermission().then((value) async {
      if (Platform.isIOS) {
        await FirebaseMessaging.instance.getAPNSToken();
      }
      FirebaseMessaging.instance.subscribeToTopic('all_${MySharedPreferences.language}');
    });
  }

  Future<void> init(BuildContext context) async {
    //await LocalNotificationsService().initialize();

    FirebaseMessaging.onMessage.listen(
      (event) {
        _handleLocalMessage(context, event);
      },
    );

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
  }

  void _handleLocalMessage(BuildContext context, RemoteMessage? message) {
    final data = message?.notification;
    log("ReceivedNotification::\nType:: ForegroundMessage\nTitle:: ${data?.title}\nBody:: ${data?.body}\nData:: ${message?.data}");
    LocalNotificationsService().display(context, message!);
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    final data = message.notification;
    debugPrint("ReceivedNotification::\nType:: Background\nTitle:: ${data?.title}\nBody:: ${data?.body}\nData:: ${message.data}");
    NotificationsRouteService().toggle(navigatorKey.currentContext!, message.data);
  }
}
