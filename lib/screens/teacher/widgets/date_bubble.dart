import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class DateBubble extends StatelessWidget {
  final String hintText;
  final void Function() onTap;
  const DateBubble({super.key, required this.hintText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.mediaQuery.width * 0.5,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.colorPalette.white,
          border: Border.all(color: context.colorPalette.greyF2F),
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        ),
        child: Text(
          hintText,
          style: TextStyle(
            color: context.colorPalette.greyDBD,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
