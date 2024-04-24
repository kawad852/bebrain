import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class TextCourse extends StatelessWidget {
  final String data;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  const TextCourse(
    this.data, {
    super.key,
    this.fontSize = 12,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color ?? context.colorPalette.grey66,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
