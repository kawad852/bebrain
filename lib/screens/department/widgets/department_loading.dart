import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/shimmer/shimmer_bubble.dart';
import 'package:bebrain/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';

class DepartmentLoading extends StatelessWidget {
  const DepartmentLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(pinned: true),
        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverToBoxAdapter(
            child: ShimmerLoading(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoadingBubble(
                    width: 100,
                    height: 35,
                    radius: MyTheme.radiusSecondary,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 10),
                    child: LoadingBubble(
                      width: 150,
                      height: 30,
                      radius: MyTheme.radiusSecondary,
                    ),
                  ),
                  LoadingBubble(
                    width: double.infinity,
                    height: 45,
                    radius: MyTheme.radiusSecondary,
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          sliver: SliverToBoxAdapter(
            child: ShimmerLoading(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LoadingBubble(
                              width: 100,
                              height: 20,
                              radius: MyTheme.radiusSecondary,
                            ),
                            LoadingBubble(
                              width: 50,
                              height: 20,
                              radius: MyTheme.radiusSecondary,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 75,
                        child: ListView.separated(
                          padding: const EdgeInsetsDirectional.only(top: 10, bottom: 10, start: 10),
                          separatorBuilder: (context, index) => const SizedBox(width: 5),
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return const LoadingBubble(
                              width: 160,
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              radius: MyTheme.radiusSecondary,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: LoadingBubble(
                      width: 75,
                      height: 20,
                      radius: MyTheme.radiusSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverList.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: 8,
            itemBuilder: (context, index) {
              return const ShimmerLoading(
                child: LoadingBubble(
                  width: double.infinity,
                  height: 110,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  radius: MyTheme.radiusSecondary,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
