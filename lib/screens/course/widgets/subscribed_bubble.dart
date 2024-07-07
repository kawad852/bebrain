import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class SubscribedBubble extends StatelessWidget {
  const SubscribedBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 23,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: context.colorPalette.blue8DD,
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary)),
      child: Text(
        context.appLocalization.subscribed,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: context.colorPalette.black33,
        ),
      ),
    );
  }
}
