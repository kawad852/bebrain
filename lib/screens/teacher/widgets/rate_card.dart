import 'package:bebrain/utils/app_constants.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateCard extends StatelessWidget {
  const RateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: context.colorPalette.greyEEE,
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CustomNetworkImage(
                kFakeImage,
                width: 40,
                height: 40,
                shape: BoxShape.circle,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "المهيار زهرة",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: context.colorPalette.black33,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "12/08/2024",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: context.colorPalette.black33,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              RatingBar.builder(
                initialRating: 1,
                minRating: 1,
                unratedColor: context.colorPalette.grey66,
                direction: Axis.horizontal,
                allowHalfRating: true,
                ignoreGestures: true,
                itemSize: 15,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 3),
                itemBuilder: (context, _) => const CustomSvg(MyIcons.star),
                onRatingUpdate: (rating) {
                  debugPrint(rating.toString());
                },
              ),
            ],
          ),
          Text(
            "استاذ مميز جداً وهذا مثال على نص يمكن كتابته عند اضافة تقييم من قبل الطالب الذي اشترك لديه في الكورس ",
            style: TextStyle(
              color: context.colorPalette.black33,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
