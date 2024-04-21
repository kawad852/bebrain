import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bebrain/main.dart';
import 'package:bebrain/notifications/notifications_routes_service.dart';
import 'package:bebrain/utils/base_extensions.dart';

class LocalNotificationsService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static late AndroidNotificationChannel androidChannel;

  Future<void> initialize() async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
      ),
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (message) {
        if (message.payload != null && message.payload!.isNotEmpty) {
          Map<String, dynamic> data = json.decode(message.payload!);
          NotificationsRouteService().toggle(navigatorKey.currentContext!, data);
        }
      },
    );
  }

  //for notifications in foreground
  void display(BuildContext context, RemoteMessage message) async {
    try {
      final data = message.notification;
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      await _flutterLocalNotificationsPlugin.show(
        id,
        data?.title,
        data?.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            channelDescription: androidChannel.description,
            importance: androidChannel.importance,
            playSound: androidChannel.playSound,
            icon: '@mipmap/ic_launcher',
            color: context.colorScheme.primary,
            sound: const RawResourceAndroidNotificationSound('end_match_helf'),
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: json.encode(message.data),
      );
    } on Exception catch (e) {
      log("Exception:: $e");
    }
  }
}
