import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IntroBubble extends StatelessWidget {
  final String icon;
  const IntroBubble({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colorPalette.blue8DD,
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      ),
      child: CustomSvg(
        icon,
        color: context.colorPalette.white,
      ),
    );
  }
}
