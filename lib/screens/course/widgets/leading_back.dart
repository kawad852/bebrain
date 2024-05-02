import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class LeadingBack extends StatelessWidget {
  const LeadingBack({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.pop();
      },
      icon: Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.colorPalette.white50,
          borderRadius: BorderRadius.circular(3),
        ),
        child: const Icon(Icons.arrow_back_rounded),
      ),
    );
  }
}
