import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class StretchedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;

  const StretchedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.margin,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          minimumSize: Size.fromHeight(context.systemButtonHeight + 4),
          textStyle: TextStyle(fontSize: 17, fontFamily: MyTheme.fontFamily),
        ),
        child: child,
      ),
    );
  }
}
