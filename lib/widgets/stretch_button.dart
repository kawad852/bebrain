import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class StretchedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? height;

  const StretchedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.margin,
    this.backgroundColor, 
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: context.colorPalette.blueC2E,
          minimumSize: Size.fromHeight(context.systemButtonHeight + (height?? 15)),
          foregroundColor: context.colorPalette.blackB0B,
          textStyle: TextStyle(
            fontSize: 17,
            fontFamily: MyTheme.fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: child,
      ),
    );
  }
}
