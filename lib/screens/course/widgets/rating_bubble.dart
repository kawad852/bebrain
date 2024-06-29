import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBubble extends StatelessWidget {
  final String title;
  final double? rate;
  final bool ignoreGestures;
  final EdgeInsetsGeometry? margin;
  final void Function(double)? onRatingUpdate;
  const RatingBubble({
    super.key,
    required this.title,
    this.rate,
    this.ignoreGestures = false,
    this.onRatingUpdate,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: margin?? const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: context.colorPalette.greyEEE,
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: CourseText(
              title,
              fontSize: 12,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          RatingBar.builder(
            initialRating: rate?? 1,
            minRating: 1,
            unratedColor: context.colorPalette.greyCBC,
            direction: Axis.horizontal,
            allowHalfRating: true,
            ignoreGestures: ignoreGestures,
            itemSize: 20,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 3),
            itemBuilder: (context, _) => const CustomSvg(MyIcons.star),
            onRatingUpdate: onRatingUpdate?? (rating) {
              debugPrint(rating.toString());
            },
          )
        ],
      ),
    );
  }
}
