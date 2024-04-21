import 'package:flutter/material.dart';
import 'package:bebrain/utils/my_theme.dart';

class LoadingBubble extends StatelessWidget {
  final double? width;
  final double radius;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxShape? shape;

  const LoadingBubble({
    super.key,
    this.width,
    this.radius = MyTheme.radiusSecondary,
    this.height,
    this.padding,
    this.margin,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: shape != null ? null : BorderRadius.circular(radius),
        shape: shape ?? BoxShape.rectangle,
      ),
    );
  }
}
