import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class ActionContainer extends StatelessWidget {
  final void Function() onTap;
  final bool hasBorder;
  final Color? color;
  final Widget child;
  const ActionContainer({
    super.key,
    required this.onTap,
    this.hasBorder = false,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          border: hasBorder ? Border.all(color: context.colorPalette.grey99) : null,
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        ),
        child: child,
      ),
    );
  }
}
