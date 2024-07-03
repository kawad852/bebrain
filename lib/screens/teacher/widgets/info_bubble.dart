import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

class InfoBubble extends StatelessWidget {
  final String icon;
  final String value;
  final String title;
  const InfoBubble({super.key, required this.icon, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomSvg(icon),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                color: context.colorPalette.black33,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: context.colorPalette.grey66,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }
}
