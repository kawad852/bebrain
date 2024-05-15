import 'package:bebrain/screens/department/widgets/course_card.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/distinguished_lectures.dart';
import 'package:bebrain/widgets/editors/base_editor.dart';
import 'package:flutter/material.dart';

class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({super.key});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(pinned: true),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "علم الحاسوب",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const CustomSvg(MyIcons.teacher),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 5, end: 10),
                          child: Text(
                            "25 ${context.appLocalization.course}",
                            style: TextStyle(
                              color: context.colorPalette.grey66,
                            ),
                          ),
                        ),
                        const CustomSvg(MyIcons.subscription),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 5),
                          child: Text(
                            "2505 ${context.appLocalization.subscriber}",
                            style: TextStyle(
                              color: context.colorPalette.grey66,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BaseEditor(
                    hintText: context.appLocalization.searchCourse,
                    hintStyle: TextStyle(
                      color: context.colorPalette.grey66,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                    initialValue: null,
                    filled: true,
                    fillColor: context.colorPalette.white,
                    prefixIcon: const IconButton(
                      onPressed: null,
                      icon: CustomSvg(MyIcons.search),
                    ),
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DistinguishedLectures(
                    title: context.appLocalization.lecturers,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      context.appLocalization.courses,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: context.colorPalette.black33,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const CourseCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}
