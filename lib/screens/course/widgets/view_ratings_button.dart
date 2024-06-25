import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/screens/course/widgets/rating_card.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class ViewRatingsButton extends StatelessWidget {
  const ViewRatingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return Dialog(
        //       insetPadding: EdgeInsets.zero,
        //       child: Container(
        //         color: Colors.white,
        //         //height: 100,
        //         child: RatingCard()),
        //     );
        //   },
        // );
      },
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
