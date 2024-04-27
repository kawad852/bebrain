import 'package:bebrain/screens/request/widgets/request_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FileCard extends StatelessWidget {
  const FileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82,
      height: 93,
      decoration: BoxDecoration(
        color: context.colorPalette.greyEEE,
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      ),
      child: Column(
        children: [
          Container(
            width: 30,
            height: 30,
            margin: const EdgeInsetsDirectional.only(top: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colorPalette.blueC2E,
              shape: BoxShape.circle,
            ),
            child: const CustomSvg(MyIcons.axes),
          ),
          const Flexible(
            child: RequestText(
              "calc.pdf",
              fontSize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            height: 21,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colorPalette.blueC2E,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(MyTheme.radiusSecondary),
                bottomRight: Radius.circular(MyTheme.radiusSecondary),
              ),
            ),
            child: RequestText(
              context.appLocalization.download,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
