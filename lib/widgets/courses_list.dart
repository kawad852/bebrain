import 'package:bebrain/model/country_filter_model.dart';
import 'package:bebrain/screens/course/course_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/evaluation_star.dart';
import 'package:flutter/material.dart';

class CoursesList extends StatelessWidget {
  final List<Course> courses;
  const CoursesList({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235,
      child: ListView.builder(
        itemCount: courses.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(top: 5, start: 13,end: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNetworkImage(
                  courses[index].image!,
                  width: 272,
                  height: 180,
                  alignment: context.isLTR ? Alignment.topLeft : Alignment.topRight,
                  radius: MyTheme.radiusSecondary,
                  onTap: () {
                    context.authProvider.checkIfUserAuthenticated(context,
                        callback: () {
                      context.push(CourseScreen(courseId: courses[index].id!));
                    });
                  },
                  child:  EvaluationStar(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    evaluation: courses[index].reviewsRating!.toStringAsFixed(1),
                  ),
                ),
                SizedBox(
                  width: 272,
                  child: Text(
                    courses[index].name!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: context.colorPalette.black33,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  width: 272,
                  child: Text(
                    courses[index].professor!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: context.colorPalette.grey66,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
