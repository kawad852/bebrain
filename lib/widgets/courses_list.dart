import 'package:bebrain/screens/course/course_screen.dart';
import 'package:bebrain/utils/app_constants.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/evaluation_star.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CoursesList extends StatelessWidget {
  const CoursesList({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 5,
      options: CarouselOptions(
        padEnds: false,
        viewportFraction: 0.8,
        enableInfiniteScroll: false,
        height: 220,
        onPageChanged: (index, reason) {},
      ),
      itemBuilder: (context, index, realIndex) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(top: 5, start: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage(
                kFakeImage,
                width: 272,
                height: 180,
                alignment:context.isLTR? Alignment.topLeft: Alignment.topRight,
                radius: MyTheme.radiusSecondary,
                onTap: () => context.push(const CourseScreen()),
                child: const EvaluationStar(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  evaluation: "4.8",
                ),
              ),
              Flexible(
                child: Text(
                  "اساسيات البرمجة المتقدمة",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: context.colorPalette.black33,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  "د. احمد محمد",
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
    );
  }
}