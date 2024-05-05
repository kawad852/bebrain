import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double? fontSize;
  final Widget? prefixIcon;
  final FontWeight? fontWeight;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.fontSize,
    this.prefixIcon,
    this.fontWeight,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsetsDirectional.all(12),
        fillColor: context.colorPalette.white,
        hintText: hintText,
        hintStyle: TextStyle(
          color: context.colorPalette.grey66,
          fontWeight: fontWeight,
          fontSize: fontSize ?? 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
          borderSide: BorderSide(color: context.colorPalette.greyF2F),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
          borderSide: BorderSide(color: context.colorPalette.greyF2F),
        ),
        prefixIcon: prefixIcon,
      ),
    );
  }
}
