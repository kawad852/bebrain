import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class FreeBubble extends StatelessWidget {
  const FreeBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 23,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colorPalette.greyD9D,
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      ),
      child: Text(
        context.appLocalization.free,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: context.colorPalette.black33,
        ),
      ),
    );
  }
}
