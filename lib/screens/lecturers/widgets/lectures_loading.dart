import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/shimmer/shimmer_bubble.dart';
import 'package:flutter/material.dart';

class LecturesLoading extends StatelessWidget {
  final bool isOnLine;
  const LecturesLoading({super.key, this.isOnLine = false});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 8,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: isOnLine? 0 : 10),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2),
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
