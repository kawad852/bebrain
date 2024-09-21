import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/shimmer/shimmer_bubble.dart';
import 'package:flutter/material.dart';

class SubjectLoading extends StatelessWidget {
  const SubjectLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: List.generate(
        6,
        (index) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoadingBubble(
              height: 34,
              width: 100,
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
              radius: MyTheme.radiusSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
