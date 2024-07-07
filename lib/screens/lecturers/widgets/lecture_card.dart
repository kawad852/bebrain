import 'package:bebrain/model/professors_model.dart';
import 'package:bebrain/screens/teacher/teacher_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/evaluation_star.dart';
import 'package:flutter/material.dart';

class LectureCard extends StatelessWidget {
  final ProfessorData professor;
  const LectureCard({super.key, required this.professor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: context.colorPalette.greyEEE,
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      ),
      child: Column(
        children: [
          CustomNetworkImage(
            professor.image!,
            width: 91,
            height: 91,
            shape: BoxShape.circle,
            alignment: context.isLTR ? Alignment.topLeft : Alignment.topRight,
            onTap: () => context.push(TeacherScreen(professorId: professor.id!)),
            child: EvaluationStar(
              evaluation: professor.reviewsRating!.toStringAsFixed(1),
            ),
          ),
          Flexible(
            child: Text(
              professor.name!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: Text(
              professor.universityName!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: context.colorPalette.grey66,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: Text(
              "${professor.subscriptionCount} ${context.appLocalization.subscriber}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: context.colorPalette.grey66,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
