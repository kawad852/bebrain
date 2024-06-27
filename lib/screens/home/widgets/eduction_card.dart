import 'package:bebrain/model/continue_learning_model.dart';
import 'package:bebrain/screens/course/course_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class EductionCard extends StatelessWidget {
  final LearningData learningData;
  const EductionCard({super.key, required this.learningData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(CourseScreen(courseId: learningData.id!));
      },
      child: Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          color: context.colorPalette.blueC2E,
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 35,
              height: 39,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colorPalette.blueA3C,
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
              ),
              child: Text(
                "${learningData.percentage}\n%",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.colorPalette.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
             Flexible(
              child: Text(
                learningData.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
            Text(
              "${learningData.videosCount} ${context.appLocalization.video}, ${learningData.hours} ${context.appLocalization.hour}",
              style: TextStyle(
                color: context.colorPalette.grey66,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
