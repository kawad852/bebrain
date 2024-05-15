import 'package:bebrain/screens/course/widgets/content_card.dart';
import 'package:bebrain/screens/course/widgets/course_info.dart';
import 'package:bebrain/screens/course/widgets/course_nav_bar.dart';
import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/screens/course/widgets/leading_back.dart';
import 'package:bebrain/screens/course/widgets/lecture_card.dart';
import 'package:bebrain/screens/course/widgets/rating_card.dart';
import 'package:bebrain/screens/course/widgets/view_ratings_button.dart';
import 'package:bebrain/utils/app_constants.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/courses_list.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CourseNavBar(),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            scrolledUnderElevation: 0,
            collapsedHeight: kBarCollapsedHeight,
            leading: LeadingBack(),
            flexibleSpace:  CustomNetworkImage(
              kFakeImage,
              height: 258,
              radius: 0,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Expanded(
                        child: CourseText(
                          "محاسبة الشركات",
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ViewRatingsButton(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 7),
                    child: Row(
                      children: [
                        Expanded(
                          child: CourseText(
                            "الجامعة الأردنية",
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            textColor: context.colorPalette.grey66,
                          ),
                        ),
                        Row(
                          children: [
                            const CustomSvg(MyIcons.star),
                            const SizedBox(width: 5),
                            CourseText(
                              "( 85 ) 4.8",
                              textColor: context.colorPalette.grey66,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const CourseText(
                    "وصف قصير عن كورس محاسبة الشركات للجامعة الأردنية وصف قصير عن كورس محاسبة الشركات للجامعة الأردنية وصف قصير عن كورس محاسبة الشركات للجامعة الأردنية ",
                  ),
                  const SizedBox(height: 10),
                  const CourseInfo(),
                  StretchedButton(
                    onPressed: () {},
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      children: [
                        CourseText(
                          context.appLocalization.join,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          textColor: context.colorPalette.black33,
                        ),
                        CourseText(
                          context.appLocalization.getPatFree,
                          fontSize: 12,
                          textColor: context.colorPalette.black33,
                        ),
                      ],
                    ),
                  ),
                  CourseText(
                    context.appLocalization.contents,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: 4,
              itemBuilder: (context, index) {
                return const ContentCard();
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CourseText(
                    context.appLocalization.aboutTheTeacher,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const LectureCard(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CourseText(
                        context.appLocalization.ratings,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      const ViewRatingsButton(),
                    ],
                  ),
                  Row(
                    children: [
                      const CustomSvg(MyIcons.star, width: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: CourseText(
                          "5/4.5",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CourseText(
                        context.appLocalization.basedOnRatings(91),
                        fontSize: 12,
                      ),
                    ],
                  ),
                  const RatingCard(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CourseText(
                    context.appLocalization.more,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: CoursesList(courses: [],),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
