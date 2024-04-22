import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavBarItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final String icon;
  final String title;
  final double? width;

  const NavBarItem({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.icon,
    required this.title,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? context.colorPalette.black33 : null;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: AnimatedScale(
              scale: isSelected ? 1.2 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomSvg(
                    icon,
                    // height: 25,
                    width: width,
                    color: color,
                  ),
                  Text(
                    title,
                    style: context.textTheme.labelSmall!.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
