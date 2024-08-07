import 'package:bebrain/model/teacher_model.dart';
import 'package:bebrain/screens/teacher/booking_lecture_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class TeacherNavBar extends StatelessWidget {
  final TeacherData teacherData;
  const TeacherNavBar({super.key, required this.teacherData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: context.colorPalette.blueC2E,
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                context.appLocalization.bookPrivateLecture,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                context.authProvider.checkIfUserAuthenticated(context, callback: (){
                  context.push(BookingLectureScreen(teacherData: teacherData));
                });
              },
              child: Container(
                width: 55,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.colorPalette.blue8DD,
                  borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                ),
                child: Text(
                  context.appLocalization.booking,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
