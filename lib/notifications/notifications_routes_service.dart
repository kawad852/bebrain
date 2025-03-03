import 'package:bebrain/screens/booking/booking_request_screen.dart';
import 'package:bebrain/screens/notifications/notifications_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class NotificationsRouteService {
  void toggle(BuildContext context, Map<String, dynamic> data) {
    try {
      // final id = data['id'] as String?;
      final type = data['type'] as String?;
      switch (type) {
        case "interview_request":
          context.push(
            BookingRequestScreen(interViewId: int.parse(data['id']))
          );
          break;
        default: context.push(
          const NotificationsScreen()
        );
      }
    } catch (e) {
      debugPrint("RouteError:: $e");
    }
  }
}
