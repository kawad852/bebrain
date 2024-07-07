import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/shimmer/shimmer_bubble.dart';
import 'package:flutter/material.dart';

class ProfileLoading extends StatelessWidget {
  const ProfileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            LoadingBubble(
              width: 53,
              height: 53,
              shape: BoxShape.circle,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoadingBubble(
                    width: 100,
                    height: 27,
                    margin: EdgeInsets.symmetric(vertical: 3),
                    radius: MyTheme.radiusSecondary,
                  ),
                  LoadingBubble(
                    width: 170,
                    height: 20,
                    radius: MyTheme.radiusSecondary,
                  ),
                ],
              ),
            ),
          ],
        ),
        LoadingBubble(
          width: double.infinity,
          height: 61,
          margin: EdgeInsets.symmetric(vertical: 10),
          radius: MyTheme.radiusSecondary,
        ),
      ],
    );
  }
}
