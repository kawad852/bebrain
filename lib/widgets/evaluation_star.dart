import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

class EvaluationStar extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final String evaluation;
  const EvaluationStar(
      {super.key, required this.margin, required this.evaluation});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 20,
      margin: margin,
      decoration: BoxDecoration(
        color: context.colorPalette.white,
        borderRadius: BorderRadius.circular(MyTheme.radiusPrimary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomSvg(MyIcons.star),
          const SizedBox(width: 5),
          Text(evaluation),
        ],
      ),
    );
  }
}
