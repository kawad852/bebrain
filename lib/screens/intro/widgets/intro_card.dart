import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_images.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class IntroCard extends StatelessWidget {
  final String title;
  final bool isRating;
  const IntroCard({super.key, required this.title, this.isRating = false});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 13,
      child: Center(
        child: Pulse(
          animate: true,
          infinite: true,
          duration: const Duration(seconds: 6),
          child: Container(
            width: 235,
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: context.colorPalette.greyF6F,
              borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: context.colorPalette.greyE0E,
                    borderRadius: BorderRadius.circular(
                      MyTheme.radiusSecondary,
                    ),
                  ),
                  child: isRating ? const CustomSvg(MyIcons.fakeProfile): Image.asset(MyImages.logo,width: 40),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      isRating
                          ? RatingBar.builder(
                              initialRating: 5,
                              direction: Axis.horizontal,
                              ignoreGestures: true,
                              itemSize: 25,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              itemBuilder: (context, _) =>
                                  const CustomSvg(MyIcons.star),
                              onRatingUpdate: (rating) {},
                            )
                          : Text(
                              context.appLocalization.now,
                              style: TextStyle(
                                color: context.colorPalette.grey66,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
