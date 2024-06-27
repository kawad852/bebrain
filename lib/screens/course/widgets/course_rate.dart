import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/screens/course/widgets/rating_bubble.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/editors/text_editor.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseRate extends StatefulWidget {
  final String courseName;
  const CourseRate({super.key, required this.courseName});

  @override
  State<CourseRate> createState() => _CourseRateState();
}

class _CourseRateState extends State<CourseRate> {
  final _formKey = GlobalKey<FormState>();
  String? _notes;
  @override
  Widget build(BuildContext context) {
    return StretchedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  height: 465,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.colorPalette.white,
                    borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: CourseText(
                            context.appLocalization.rateExperienceCourse(widget.courseName),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RatingBubble(
                          title: context.appLocalization.audioVideoQuality,
                          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                        ),
                        RatingBubble(
                          title: context.appLocalization.valueForPrice,
                          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                        ),
                        RatingBubble(
                          title: context.appLocalization.teacherAbilityCommunicate,
                          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                        ),
                        RatingBubble(
                          title: context.appLocalization.similarityCurriculumContent,
                          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: TextEditor(
                            initialValue: _notes,
                            maxLines: 4,
                            hintText: context.appLocalization.notesHint,
                            onChanged: (value) => _notes = value,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            height: 48,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: context.colorPalette.blueC2E,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft:Radius.circular(MyTheme.radiusSecondary),
                                  bottomRight:Radius.circular(MyTheme.radiusSecondary),
                                  ),
                            ),
                            child: CourseText(
                              context.appLocalization.send,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      height: 7,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontFamily: GoogleFonts.cairo().fontFamily!,
          ),
          children: [
            TextSpan(
              text: context.appLocalization.basedOnSubsription,
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
    );
  }
}
