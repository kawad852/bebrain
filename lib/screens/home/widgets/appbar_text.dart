import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class AppBarText extends StatelessWidget {
  final String data;
  final double fontSize;
  final Color? textColor;
  final TextOverflow? overflow;
  const AppBarText(
    this.data, {
    super.key,
    this.fontSize = 18,
    this.textColor,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      overflow:overflow,
      style: TextStyle(
        color: textColor ?? context.colorPalette.grey66,
        fontSize: fontSize,
      ),
    );
  }
}
