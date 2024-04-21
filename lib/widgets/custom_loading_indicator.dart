import 'package:flutter/material.dart';
import 'package:bebrain/utils/base_extensions.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final bool withBackgroundColor;

  const CustomLoadingIndicator({
    super.key,
    this.withBackgroundColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: withBackgroundColor ? MaterialType.canvas : MaterialType.transparency,
      color: context.colorScheme.background,
      child: Center(
        child: context.loaders.circular(),
      ),
    );
  }
}
