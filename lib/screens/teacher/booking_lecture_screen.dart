import 'package:bebrain/model/teacher_model.dart';
import 'package:bebrain/screens/teacher/widgets/teacher_info.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class BookingLectureScreen extends StatefulWidget {
  final TeacherData teacherData;
  const BookingLectureScreen({super.key, required this.teacherData});

  @override
  State<BookingLectureScreen> createState() => _BookingLectureScreenState();
}

class _BookingLectureScreenState extends State<BookingLectureScreen> {
  TeacherData get _teacher => widget.teacherData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            collapsedHeight: 170,
            flexibleSpace: Container(
              color: context.colorPalette.blueC2E,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: 50),
                child: TeacherInfo(teacher: _teacher),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Text(
                    context.appLocalization.toBookLectureWithProfessor,
                    style: TextStyle(
                      color: context.colorPalette.grey66,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
