import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/shimmer/shimmer_bubble.dart';
import 'package:bebrain/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';

class BookingRequestLoading extends StatelessWidget {
  const BookingRequestLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const ShimmerLoading(
        child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: LoadingBubble(
            width: double.infinity,
            height: 66,
            radius: MyTheme.radiusSecondary,
            margin: EdgeInsets.symmetric(horizontal: 15),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(pinned: true),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: ShimmerLoading(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LoadingBubble(
                          width: 200,
                          height: 30,
                          radius: MyTheme.radiusSecondary,
                        ),
                        LoadingBubble(
                          width: 68,
                          height: 23,
                          radius: MyTheme.radiusSecondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    const LoadingBubble(
                      width: 200,
                      height: 15,
                      radius: MyTheme.radiusPrimary,
                    ),
                    const SizedBox(height: 10),
                    const LoadingBubble(
                      width: double.infinity,
                      height: 43,
                      radius: MyTheme.radiusSecondary,
                    ),
                    const LoadingBubble(
                      width: double.infinity,
                      height: 43,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      radius: MyTheme.radiusSecondary,
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: LoadingBubble(
                            width: double.infinity,
                            height: 43,
                            radius: MyTheme.radiusSecondary,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: LoadingBubble(
                            width: double.infinity,
                            height: 43,
                            radius: MyTheme.radiusSecondary,
                          ),
                        ),
                      ],
                    ),
                    const LoadingBubble(
                      width: double.infinity,
                      height: 43,
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      radius: MyTheme.radiusSecondary,
                    ),
                    const Row(
                      children: [
                        LoadingBubble(
                          width: 22,
                          height: 22,
                          radius: MyTheme.radiusPrimary,
                        ),
                        SizedBox(width: 10),
                        LoadingBubble(
                          width: 100,
                          height: 25,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 95,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(width: 6),
                        itemCount: 7,
                        padding: const EdgeInsetsDirectional.only(top: 5, end: 10),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return const LoadingBubble(
                            width: 82,
                            height: 95,
                            radius: MyTheme.radiusSecondary,
                          );
                        },
                      ),
                    ),
                    const LoadingBubble(
                      width: double.infinity,
                      height: 85,
                      margin: EdgeInsets.symmetric(vertical: 15),
                      radius: MyTheme.radiusSecondary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
