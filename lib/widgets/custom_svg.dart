import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvg extends StatelessWidget {
  final String icon;
  final Color? color;
  final Color? darkColor;
  final double? height, width;
  final bool fixedColor;

  const CustomSvg(
    this.icon, {
    super.key,
    this.color,
    this.darkColor,
    this.height,
    this.width,
    this.fixedColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: height,
      width: width,
      color: fixedColor ? null : color,
      // colorFilter: ColorFilter.mode(
      //   context.colorScheme.inverseSurface,
      //   BlendMode.srcIn,
      // ),
    );
  }
}
