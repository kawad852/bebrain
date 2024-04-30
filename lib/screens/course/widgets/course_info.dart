import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

class CourseInfo extends StatelessWidget {
  const CourseInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              CourseText(
                "712",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              CourseText(
                context.appLocalization.subscribers,
                fontSize: 12,
                textColor: context.colorPalette.grey66,
              ),
            ],
          ),
        ),
        const CustomSvg(MyIcons.line),
        const SizedBox(width: 5),
        Expanded(
          child: Column(
            children: [
              CourseText(
                "10h , 13 min",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              CourseText(
                context.appLocalization.totalDuration,
                fontSize: 12,
                textColor: context.colorPalette.grey66,
              ),
            ],
          ),
        ),
        const SizedBox(width: 5),
        const CustomSvg(MyIcons.line),
        Expanded(
          child: Column(
            children: [
              CourseText(
                "20",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              CourseText(
                context.appLocalization.videos,
                fontSize: 12,
                textColor: context.colorPalette.grey66,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
