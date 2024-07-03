import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeacherRate extends StatefulWidget {
  const TeacherRate({super.key});

  @override
  State<TeacherRate> createState() => _TeacherRateState();
}

class _TeacherRateState extends State<TeacherRate> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.colorPalette.blueE4F,
          border: Border.all(
            color: context.colorPalette.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontFamily: GoogleFonts.cairo().fontFamily!,
            ),
            children: [
              TextSpan(
                text: context.appLocalization.basedOnSubsriptionTeacher,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: context.colorPalette.black33,
                ),
              ),
              const WidgetSpan(child: CustomSvg(MyIcons.star, height: 19)),
              TextSpan(
                text: context.appLocalization.rateYourExperience,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: context.colorPalette.black33,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
