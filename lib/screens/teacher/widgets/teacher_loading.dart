import 'package:bebrain/utils/my_images.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_loading_indicator.dart';
import 'package:bebrain/widgets/shimmer/shimmer_bubble.dart';
import 'package:bebrain/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';

class TeacherLoading extends StatelessWidget {
  const TeacherLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            collapsedHeight: 320,
            flexibleSpace: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(MyImages.teacherBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      ShimmerLoading(
                        child: LoadingBubble(
                          width: 90,
                          height: 90,
                          radius: MyTheme.radiusSecondary,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(child: CustomLoadingIndicator()),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      height: 50,
                    ),
                  ),
                  ShimmerLoading(
                    child: LoadingBubble(
                      width: double.infinity,
                      height: 45,
                      radius: MyTheme.radiusSecondary,
                    ),
                  ),
                  SizedBox(height: 10),
                  ShimmerLoading(
                    child: LoadingBubble(
                      width: double.infinity,
                      height: 50,
                      radius: MyTheme.radiusSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
           SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: ShimmerLoading(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LoadingBubble(
                      width: 110,
                      height: 30,
                      radius: MyTheme.radiusPrimary,
                    ),
                    const LoadingBubble(
                      width: double.infinity,
                      height: 25,
                      radius: MyTheme.radiusPrimary,
                      margin: EdgeInsets.symmetric(vertical: 3),
                    ),
                    SizedBox(
                      height: 34,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(width: 2),
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          return const LoadingBubble(
                            width: 84,
                            height: 34,
                            radius: MyTheme.radiusSecondary,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerLoading(
                    child: LoadingBubble(
                      width: 90,
                      height: 30,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      radius: MyTheme.radiusPrimary,
                    ),
                  ),
                  SizedBox(
                    height: 235,
                    child: ShimmerLoading(
                      child: ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return const Padding(
                              padding:
                                  EdgeInsetsDirectional.only(top: 5, start: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LoadingBubble(
                                    width: 272,
                                    height: 180,
                                    radius: MyTheme.radiusSecondary,
                                  ),
                                  SizedBox(height: 5),
                                  LoadingBubble(
                                    width: 100,
                                    height: 20,
                                    radius: MyTheme.radiusSecondary,
                                  ),
                                  SizedBox(height: 5),
                                  LoadingBubble(
                                    width: 50,
                                    height: 20,
                                    radius: MyTheme.radiusSecondary,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerLoading(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LoadingBubble(
                          width: 90,
                          height: 20,
                          radius: MyTheme.radiusPrimary,
                        ),
                        LoadingBubble(
                          width: 110,
                          height: 20,
                          radius: MyTheme.radiusPrimary,
                        ),
                      ],
                    ),
                  ),
                  ShimmerLoading(
                    child: LoadingBubble(
                      width: 150,
                      height: 20,
                      radius: MyTheme.radiusPrimary,
                      margin: EdgeInsets.symmetric(vertical: 3),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: 4,
              itemBuilder: (context, index) {
                return const ShimmerLoading(
                  child: LoadingBubble(
                    width: double.infinity,
                    height: 103,
                    radius: MyTheme.radiusSecondary,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
