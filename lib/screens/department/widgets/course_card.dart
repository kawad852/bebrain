import 'package:bebrain/model/country_filter_model.dart';
import 'package:bebrain/screens/course/course_screen.dart';
import 'package:bebrain/screens/department/widgets/text_course.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/evaluation_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push(CourseScreen(courseId: course.id!));
      },
      child: Container(
        width: double.infinity,
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: context.colorPalette.white,
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
          border: Border.all(
            color: context.colorPalette.greyF2F,
          ),
        ),
        child: Row(
          children: [
             CustomNetworkImage(
              course.image!,
              width: 90,
              height: 90,
              radius: MyTheme.radiusSecondary,
              alignment: Alignment.topLeft,
              child: const EvaluationStar(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                evaluation: "4.8",
              ),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCourse(
                    course.name!,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.colorPalette.black33,
                  ),
                   TextCourse(
                    course.professor!,
                    fontSize: 14,
                  ),
                   TextCourse(course.description!),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const CustomSvg(MyIcons.subscription),
                      const Padding(
                        padding: EdgeInsetsDirectional.only(start: 5, end: 8),
                        child: TextCourse("195"),
                      ),
                      const CustomSvg(MyIcons.video),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.only(start: 5, end: 8),
                        child: TextCourse("${course.videosCount} ${context.appLocalization.video}"),
                      ),
                      const CustomSvg(MyIcons.axes),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 5),
                        child: TextCourse("${course.unitCount} ${context.appLocalization.axes}"),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
