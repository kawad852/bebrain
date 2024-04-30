import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingCard extends StatelessWidget {
  const RatingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 6),
      itemCount: 4,
      padding: const EdgeInsets.only(top: 15),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: context.colorPalette.greyEEE,
            borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: CourseText(
                  "جودة الصوت والصورة",
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              RatingBar.builder(
                initialRating: 3.2,
                minRating: 0,
                unratedColor: context.colorPalette.greyCBC,
                direction: Axis.horizontal,
                allowHalfRating: true,
                ignoreGestures: true,
                itemSize: 15,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 3),
                itemBuilder: (context, _) => const CustomSvg(MyIcons.star),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
