import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class Point extends StatelessWidget {
  const Point({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: context.colorPalette.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
