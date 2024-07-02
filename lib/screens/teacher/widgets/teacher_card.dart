import 'package:bebrain/model/teacher_model.dart';
import 'package:bebrain/screens/teacher/widgets/info_bubble.dart';
import 'package:bebrain/screens/teacher/widgets/teacher_rate.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_images.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TeacherCard extends StatefulWidget {
  final TeacherData teacherData;
  const TeacherCard({super.key, required this.teacherData});

  @override
  State<TeacherCard> createState() => _TeacherCardState();
}

class _TeacherCardState extends State<TeacherCard> {
  TeacherData get _teacher => widget.teacherData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(MyImages.teacherBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              CustomNetworkImage(
                _teacher.image!,
                width: 90,
                height: 90,
                radius: MyTheme.radiusSecondary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _teacher.name!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: context.colorPalette.black33,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      _teacher.universityName!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: context.colorPalette.grey66,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: _teacher.reviewsRating!,
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
                          "(${_teacher.reviewsRating!.toStringAsFixed(1)})",
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
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 50,
              child: Text(
                _teacher.description!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: context.colorPalette.grey66,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          context.authProvider.isAuthenticated
              ? const TeacherRate()
              : const SizedBox(height: 45),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: context.colorPalette.greyEEE,
              borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoBubble(
                  title: context.appLocalization.course,
                  value: "${_teacher.coursesCount}",
                  icon: MyIcons.axes,
                ),
                InfoBubble(
                  title: context.appLocalization.video,
                  value: "${_teacher.videosCount}",
                  icon: MyIcons.video,
                ),
                InfoBubble(
                  title: context.appLocalization.subscriber,
                  value: "${_teacher.subscriptionCount}",
                  icon: MyIcons.subscription,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
