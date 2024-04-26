import 'dart:math';

import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

class RequestMenu extends StatelessWidget {
  final String hintText;
  const RequestMenu({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        border: Border.all(
          color: context.colorPalette.greyF2F,
        ),
      ),
      child: DropdownMenu(
        hintText: hintText,
        trailingIcon: const CustomSvg(MyIcons.arrowDown),
        selectedTrailingIcon: Transform.rotate(angle: -pi,child: const CustomSvg(MyIcons.arrowDown)),
        textStyle: TextStyle(
          color: context.colorPalette.grey66,
          fontSize: 14,
        ),
        expandedInsets: EdgeInsets.zero,
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
        ),
        dropdownMenuEntries: const <DropdownMenuEntry<String>>[
          DropdownMenuEntry(value: "Syria", label: "Syria"),
          DropdownMenuEntry(value: "Jordon", label: "Jordon"),
        ],
      ),
    );
  }
}
