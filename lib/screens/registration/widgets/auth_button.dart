import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onTap;
  final String icon;
  final String text;
  final Color backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;
  final ShapeBorder? shape;

  const AuthButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
    required this.backgroundColor,
    this.foregroundColor,
    this.shape,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: backgroundColor,
          ),
          child: Material(
            type: MaterialType.transparency,
            child: ListTile(
              onTap: onTap,
              dense: true,
              textColor: foregroundColor,
              iconColor: foregroundColor,
              shape: shape ??
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
              titleAlignment: ListTileTitleAlignment.center,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSvg(icon),
                  const SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
