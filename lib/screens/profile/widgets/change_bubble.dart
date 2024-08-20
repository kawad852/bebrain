import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class ChangeBubble extends StatelessWidget {
  final void Function() onTap;
  const ChangeBubble({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 20,
        alignment: Alignment.center,
        color: context.colorPalette.blue8DD,
        child: Text(
          context.appLocalization.edit,
          style: TextStyle(
            color: context.colorPalette.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
