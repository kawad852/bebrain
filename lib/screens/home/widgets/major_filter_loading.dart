import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/shimmer/shimmer_bubble.dart';
import 'package:flutter/material.dart';

class MajorFilterLoading extends StatelessWidget {
  const MajorFilterLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LoadingBubble(
            width: 100,
            height: 35,
            radius: MyTheme.radiusSecondary,
          ),
          const Padding(
            padding: EdgeInsetsDirectional.symmetric(vertical: 10),
            child: LoadingBubble(
              width: 150,
              height: 30,
              radius: MyTheme.radiusSecondary,
            ),
          ),
          const LoadingBubble(
            width: double.infinity,
            height: 45,
            radius: MyTheme.radiusSecondary,
          ),
          // const SizedBox(height: 15),
          // const Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     LoadingBubble(
          //       width: 100,
          //       height: 20,
          //       radius: MyTheme.radiusSecondary,
          //     ),
          //     LoadingBubble(
          //       width: 50,
          //       height: 20,
          //       radius: MyTheme.radiusSecondary,
          //     ),
          //   ],
          // ),
          const LoadingBubble(
            width: 75,
            height: 20,
            margin: EdgeInsets.symmetric(vertical: 10),
            radius: MyTheme.radiusSecondary,
          ),
          ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: 8,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const LoadingBubble(
                width: double.infinity,
                height: 110,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                radius: MyTheme.radiusSecondary,
              );
            },
          ),
        ],
      ),
    );
  }
}
