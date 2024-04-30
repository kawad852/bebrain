import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class CourseText extends StatelessWidget {
  final String data;
  final Color? textColor;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextAlign? textAlign;
  const CourseText(
    this.data, {
    super.key,
    this.textColor,
    this.fontSize = 14,
    this.fontWeight,
    this.overflow,
    this.decoration,
    this.maxLines,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationThickness: 2,
        decorationColor: context.colorPalette.grey66,
      ),
    );
  }
}
