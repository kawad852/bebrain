import 'package:bebrain/utils/enums.dart';
import 'package:flutter/material.dart';

class NotificationsRouteService {
  void toggle(BuildContext context, Map<String, dynamic> data) {
    try {
      // final id = data['id'] as String?;
      final type = data['type'] as String?;
      switch (type) {
        case NotificationsType.blog:
          // context.push(
          //   MaterialPageRoute(
          //     builder: (context) => NewsDetailsScreen(newId: int.parse(id!)),
          //   ),
          // );
          break;
      }
    } catch (e) {
      debugPrint("RouteError:: $e");
    }
  }
}
