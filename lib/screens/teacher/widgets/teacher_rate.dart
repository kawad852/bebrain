import 'package:bebrain/alerts/errors/app_error_feedback.dart';
import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/model/teacher_review_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/editors/text_editor.dart';
import 'package:bebrain/widgets/rating_failer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class TeacherRate extends StatefulWidget {
  final String professorName;
  final int professorId;
  const TeacherRate(
      {super.key, required this.professorName, required this.professorId});

  @override
  State<TeacherRate> createState() => _TeacherRateState();
}

class _TeacherRateState extends State<TeacherRate> {
  final _formKey = GlobalKey<FormState>();
  String? _notes;
  double _rating = 1;

  void _rateProfessor() {
    if (_formKey.currentState!.validate()) {
      context.pop();
      ApiFutureBuilder<TeacherReviewModel>().fetch(
        context,
        future: () async {
          final rating = context.mainProvider.rateProfessor(
            comment: _notes!,
            professorId: widget.professorId,
            rating: _rating,
          );
          return rating;
        },
        onComplete: (snapshot) {
          if (snapshot.code == 200) {
            context.showSnackBar(context.appLocalization.ratingAddedSuccess);
          } else if (snapshot.code == 500) {
            showDialog(
              context: context,
              builder: (context) {
                return const Dialog(
                  insetPadding: EdgeInsets.symmetric(horizontal: 15),
                  child: RatingFailer(),
                );
              },
            );
          } else if (snapshot.code == 401) {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  insetPadding: const EdgeInsets.symmetric(horizontal: 15),
                  child: RatingFailer(
                    title: context.appLocalization.notSubscribedProfessor,
                    body: context.appLocalization.mustSubscriberWithProfessor,
                  ),
                );
              },
            );
          }
        },
        onError: (failure) => AppErrorFeedback.show(context, failure),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.authProvider.checkIfUserAuthenticated(
          context,
          callback: (){
             showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.colorPalette.white,
                      borderRadius:BorderRadius.circular(MyTheme.radiusSecondary),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            child: CourseText(
                              context.appLocalization.rateExperienceProfessor(widget.professorName),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: 1,
                            minRating: 1,
                            unratedColor: context.colorPalette.greyCBC,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            ignoreGestures: false,
                            itemSize: 25,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 6),
                            itemBuilder: (context, _) => const CustomSvg(MyIcons.star),
                            onRatingUpdate: (rating) => _rating = rating,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            child: TextEditor(
                              initialValue: _notes,
                              maxLines: 4,
                              hintText: context.appLocalization.notesHint,
                              onChanged: (value) => _notes = value,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              _rateProfessor();
                            },
                            child: Container(
                              width: double.infinity,
                              height: 48,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: context.colorPalette.blueC2E,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(MyTheme.radiusSecondary),
                                  bottomRight: Radius.circular(MyTheme.radiusSecondary),
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
         }
        );
      },
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
