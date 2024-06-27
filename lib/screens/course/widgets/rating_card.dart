import 'package:bebrain/screens/course/widgets/rating_bubble.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class RatingCard extends StatelessWidget {
  final double audioVideoRating;
  final double valueForMoney;
  final double conveyIdea;
  final double similarityCurriculumContent;
  const RatingCard({
    super.key,
    required this.audioVideoRating,
    required this.valueForMoney,
    required this.conveyIdea,
    required this.similarityCurriculumContent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingBubble(
          title: context.appLocalization.audioVideoQuality,
          rate: audioVideoRating,
          ignoreGestures: true,
        ),
        RatingBubble(
          title: context.appLocalization.valueForPrice,
          rate: valueForMoney,
          ignoreGestures: true,
        ),
        RatingBubble(
          title: context.appLocalization.teacherAbilityCommunicate,
          rate: conveyIdea,
          ignoreGestures: true,
        ),
        RatingBubble(
          title: context.appLocalization.similarityCurriculumContent,
          rate: similarityCurriculumContent,
          ignoreGestures: true,
        ),
      ],
    );
  }
}
