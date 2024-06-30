import 'package:bebrain/screens/teacher/widgets/rate_card.dart';
import 'package:bebrain/screens/teacher/widgets/teacher_card.dart';
import 'package:bebrain/screens/teacher/widgets/teacher_nav_bar.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/widgets/courses_list.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/view_ratings_button.dart';
import 'package:flutter/material.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const TeacherNavBar(),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            collapsedHeight: 320,
            flexibleSpace: TeacherCard(),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      context.appLocalization.courses,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const CoursesList(
                    courses: [],
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.appLocalization.ratings,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const ViewRatingsButton(),
                    ],
                  ),
                  Row(
                    children: [
                      const CustomSvg(MyIcons.star, width: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "5/4.5",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        context.appLocalization.basedOnRatings("10"),
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const RateCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}
