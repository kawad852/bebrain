import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/shimmer/shimmer_bubble.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FilterLoading extends StatelessWidget {
  const FilterLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: 3,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          width: 30,
                          height: 20,
                          radius: MyTheme.radiusSecondary,
                        ),
                      ],
                    ),
                  ),
                  CarouselSlider.builder(
                      itemCount: 3,
                      options: CarouselOptions(
                        padEnds: false,
                        viewportFraction: 0.8,
                        enableInfiniteScroll: false,
                        height: 235,
                        onPageChanged: (index, reason) {},
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return const Padding(
                          padding: EdgeInsetsDirectional.only(top: 5, start: 5),
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
                  SizedBox(
                    height: 50,
                    child: ListView.separated(
                        padding: const EdgeInsetsDirectional.only( start: 10, top: 10, bottom: 10),
                        separatorBuilder: (context, index) => const SizedBox(width: 5),
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return const LoadingBubble(
                            width: 90,
                            height: 34,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            radius: MyTheme.radiusSecondary,
                          );
                        }),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
