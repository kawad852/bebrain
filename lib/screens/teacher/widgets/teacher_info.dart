import 'package:bebrain/model/teacher_model.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TeacherInfo extends StatelessWidget {
  final TeacherData teacher;
  const TeacherInfo({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomNetworkImage(
          teacher.image!,
          width: 90,
          height: 90,
          radius: MyTheme.radiusSecondary,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                teacher.name!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: context.colorPalette.black33,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              // Text(
              //   teacher.universityName!,
              //   overflow: TextOverflow.ellipsis,
              //   style: TextStyle(
              //     color: context.colorPalette.grey66,
              //     fontWeight: FontWeight.w600,
              //     fontSize: 14,
              //   ),
              // ),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: teacher.reviewsRating!,
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
                  const SizedBox(width: 10),
                  Text(
                    "(${teacher.reviewsRating!.toStringAsFixed(1)})",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.colorPalette.grey66,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
