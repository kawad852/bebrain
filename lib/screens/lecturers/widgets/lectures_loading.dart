import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/shimmer/shimmer_bubble.dart';
import 'package:flutter/material.dart';

class LecturesLoading extends StatelessWidget {
  const LecturesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 8,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, snaphot) {
        return const LoadingBubble(
          height: 185,
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          radius: MyTheme.radiusSecondary,
        );
      },
    );
  }
}
