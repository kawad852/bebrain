import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class ViewRatingsButton extends StatelessWidget {
  const ViewRatingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          CourseText(
            context.appLocalization.viewRatings,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(width: 5),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
        ],
      ),
    );
  }
}
