import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class MoreButton extends StatelessWidget {
  final void Function() onTap;
  const MoreButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            context.appLocalization.more,
            style: TextStyle(
              fontSize: 12,
              color: context.colorPalette.grey66,
            ),
          ),
          const SizedBox(width: 3),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 12,
            color: context.colorPalette.grey66,
          )
        ],
      ),
    );
  }
}
