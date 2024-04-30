import 'package:flutter/material.dart';

class RequestText extends StatelessWidget {
  final String data;
  final Color? textColor;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;
  const RequestText(
    this.data, {
    super.key,
    this.textColor,
    this.fontSize = 14,
    this.fontWeight,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
