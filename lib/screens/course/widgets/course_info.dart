import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

class CourseInfo extends StatelessWidget {
  final int videoCount;
  final int hours;
  final int minutes;
  const CourseInfo({super.key, required this.videoCount, required this.hours, required this.minutes});

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
                "${hours}h , ${minutes}min",
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
                "$videoCount",
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
