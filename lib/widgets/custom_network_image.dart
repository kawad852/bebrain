import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final double? radius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BoxFit boxFit;
  final ColorFilter? colorFilter;
  final Widget? child;
  final BoxShape? shape;
  final AlignmentGeometry alignment;
  final VoidCallback? onTap;
  final BoxBorder? border;
  final Color? backgroundColor;
  final double scale;
  final bool ignorePlaceHolder;

  const CustomNetworkImage(
    this.url, {
    super.key,
    this.radius,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.boxFit = BoxFit.cover,
    this.colorFilter,
    this.shape,
    this.child,
    this.alignment = Alignment.center,
    this.onTap,
    this.border,
    this.backgroundColor,
    this.scale = 1,
    this.ignorePlaceHolder = false,
  });

  Widget _buildContainer({
    ImageProvider? imageProvider,
    Color? color,
  }) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
        shape: shape ?? BoxShape.rectangle,
        color: color,
        border: border,
        borderRadius: shape != null ? null : BorderRadius.circular(radius ?? MyTheme.radiusSecondary),
        image: imageProvider != null
            ? DecorationImage(
                image: imageProvider,
                fit: boxFit,
                scale: scale,
                colorFilter: colorFilter,
              )
            : null,
      ),
      child: child,
    );
  }

  ImageProvider get _imagePlaceHolder => const AssetImage('assets/android_launcher.png');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => _buildContainer(color: backgroundColor, imageProvider: imageProvider),
        placeholder: (context, url) => _buildContainer(color: context.colorScheme.surfaceVariant, imageProvider: ignorePlaceHolder ? null : _imagePlaceHolder),
        errorWidget: (context, url, error) => _buildContainer(color: context.colorScheme.surfaceVariant, imageProvider: _imagePlaceHolder),
      ),
    );
  }
}
