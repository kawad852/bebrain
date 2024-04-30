import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CourseNavBar extends StatelessWidget {
  const CourseNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        height: 66,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: context.colorPalette.blueC2E,
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CourseText(
                  "\$25",
                  fontSize: 16,
                  textColor: context.colorPalette.grey66,
                  decoration: TextDecoration.lineThrough,
                  fontWeight: FontWeight.bold,
                ),
                const CourseText(
                  "\$11",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CourseText(
                    context.appLocalization.discountEntireCourse(70),
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                  ),
                  CourseText(
                    "15 ${context.appLocalization.second}, 43 ${context.appLocalization.minute}, 5 ${context.appLocalization.hours}, 4 ${context.appLocalization.days}",
                    fontSize: 12,
                    textColor: context.colorPalette.grey66,
                  ),
                ],
              ),
            ),
            Container(
              width: 46,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colorPalette.blue8DD,
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
              ),
              child: CourseText(
                context.appLocalization.buying,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
