import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/shimmer/shimmer_bubble.dart';
import 'package:bebrain/widgets/shimmer/shimmer_loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderLoading extends StatelessWidget {
  const SliderLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: 5,
            options: CarouselOptions(
              viewportFraction: 1,
              enableInfiniteScroll: false,
              height: context.mediaQuery.height * 0.28,
              onPageChanged: (index, reason) {},
            ),
            itemBuilder: (context, index, realIndex) {
              return const LoadingBubble(
                width: double.infinity,
                height: 130,
                margin: EdgeInsets.symmetric(horizontal: 15),
                radius: MyTheme.radiusSecondary,
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: LoadingBubble(
                width: 100,
                height: 20,
                radius: MyTheme.radiusSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
