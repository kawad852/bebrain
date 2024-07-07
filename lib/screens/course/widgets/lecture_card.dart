import 'package:bebrain/model/country_filter_model.dart';
import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/screens/course/widgets/point.dart';
import 'package:bebrain/screens/teacher/teacher_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/more_button.dart';
import 'package:flutter/material.dart';

class LectureCard extends StatelessWidget {
  final Professor professor;
  const LectureCard({super.key, required this.professor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 142,
      margin: const EdgeInsets.symmetric(vertical: 10),
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
               CustomNetworkImage(
                professor.image!,
                width: 42,
                height: 42,
                radius: MyTheme.radiusSecondary,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                         Expanded(
                          child: CourseText(
                            professor.name!,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        MoreButton(onTap: () {
                          context.push(TeacherScreen(professorId:professor.id!));
                        }),
                      ],
                    ),
                    Container(
                      width: 46,
                      height: 20,
                      decoration: BoxDecoration(
                        color: context.colorPalette.white50,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomSvg(MyIcons.star),
                          const SizedBox(width: 5),
                          CourseText(
                            professor.reviewsRating!.toStringAsFixed(1),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CourseText(
                  "${context.appLocalization.views} ${professor.viewsCount}",
                  fontSize: 12,
                ),
                const Point(),
                CourseText(
                  "${professor.subscriptionCount} ${context.appLocalization.subscriber}",
                  fontSize: 12,
                ),
                const Point(),
                CourseText(
                  "${professor.coursesCount} ${context.appLocalization.article}",
                  fontSize: 12,
                ),
              ],
            ),
          ),
           Flexible(
            child: CourseText(
              professor.description!,
              fontSize: 12,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
