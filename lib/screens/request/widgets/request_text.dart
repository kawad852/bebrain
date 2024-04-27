import 'package:flutter/material.dart';

class RequestText extends StatelessWidget {
  final String data;
  final Color? textColor;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  const RequestText(
    this.data, {
    super.key,
    this.textColor,
    this.fontSize = 14,
    this.fontWeight,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      overflow: overflow,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
