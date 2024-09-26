import 'package:bebrain/model/teacher_model.dart';
import 'package:bebrain/screens/online/widgets/teacher_info_card.dart';
import 'package:bebrain/screens/teacher/booking_lecture_screen.dart';
import 'package:bebrain/screens/teacher/teacher_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

class TeacherCard extends StatelessWidget {
  final TeacherData teacherData;
  const TeacherCard({super.key, required this.teacherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: context.colorPalette.greyEEE,
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomNetworkImage(
                  teacherData.image!,
                  width: 70,
                  height: 75,
                  radius: MyTheme.radiusSecondary,
                  onTap: () {
                    context.push(TeacherScreen(professorId: teacherData.id!));
                  },
                ),
                Column(
                  children: [
                    TeacherInfoCard(
                      icon: MyIcons.clock,
                      isPrice: true,
                      value: "${teacherData.interviewHourPrice!.toStringAsFixed(1)} ${MySharedPreferences.user.currencySympol}",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TeacherInfoCard(
                        icon: MyIcons.star,
                        value: "5/${teacherData.reviewsRating!.toStringAsFixed(1)}",
                      ),
                    ),
                    TeacherInfoCard(
                      icon: MyIcons.subscription,
                      value: "${teacherData.subscriptionCount}",
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              teacherData.name!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.colorPalette.black33,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),
          if (teacherData.subjects!.isNotEmpty && teacherData.interviewDays!.isNotEmpty)
            GestureDetector(
              onTap: () {
                context.push(BookingLectureScreen(teacherData: teacherData));
              },
              child: Container(
                width: double.infinity,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(MyTheme.radiusSecondary),
                    bottomRight: Radius.circular(MyTheme.radiusSecondary),
                  ),
                  color: context.colorPalette.blueC2E,
                ),
                child: Text(
                  context.appLocalization.bookNow,
                  style: TextStyle(
                    color: context.colorPalette.black33,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
