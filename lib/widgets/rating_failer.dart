import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class RatingFailer extends StatelessWidget {
  final String? title;
  final String? body;
  const RatingFailer({super.key, this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: context.colorPalette.white,
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: CourseText(
              title?? context.appLocalization.alreadyAddedRating,
              textAlign: TextAlign.center,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CourseText(
              body?? context.appLocalization.cannotMoreOneRating,
              textAlign: TextAlign.center,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Container(
              width: double.infinity,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colorPalette.blueC2E,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(MyTheme.radiusSecondary),
                  bottomRight: Radius.circular(MyTheme.radiusSecondary),
                ),
              ),
              child: CourseText(
                context.appLocalization.back,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
