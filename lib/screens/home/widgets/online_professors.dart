import 'package:bebrain/model/online_professor_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/teacher/booking_lecture_screen.dart';
import 'package:bebrain/screens/teacher/teacher_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/shimmer/shimmer_bubble.dart';
import 'package:bebrain/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';

class OnlineProfessors extends StatefulWidget {
  const OnlineProfessors({super.key});

  @override
  State<OnlineProfessors> createState() => _OnlineProfessorsState();
}

class _OnlineProfessorsState extends State<OnlineProfessors> with AutomaticKeepAliveClientMixin {
  late MainProvider _mainProvider;
  late Future<OnlineProfessorModel> _professorsFuture;

  void _initializeFuture() {
    _professorsFuture = _mainProvider.fetchProfessorByCollegeFilter(context.authProvider.wizardValues.collegeId!);
  }

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomFutureBuilder(
      future: _professorsFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onError: (snapshot) => const SizedBox.shrink(),
      onLoading: () {
        return ShimmerLoading(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: LoadingBubble(
                      width: 120,
                      height: 25,
                      radius: MyTheme.radiusPrimary,
                    ),
                ),
              SizedBox(
                height: 95,
                child: ListView.separated(
                  padding: const EdgeInsetsDirectional.only(top: 10, bottom: 10, start: 10, end: 5),
                  separatorBuilder: (context, index) => const SizedBox(width: 5),
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const LoadingBubble(
                      width: 200,
                      radius: MyTheme.radiusSecondary,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      onComplete: (context, snapshot) {
        final professors = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                context.appLocalization.bookOnline,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.colorPalette.black33,
                ),
              ),
            ),
            SizedBox(
              height: 95,
              child: ListView.separated(
                padding: const EdgeInsetsDirectional.only(top: 10, bottom: 10, start: 10, end: 5),
                separatorBuilder: (context, index) => const SizedBox(width: 5),
                itemCount: professors.data!.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final professor = professors.data![index];
                  return Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: context.colorPalette.greyEEE,
                      borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 8, start: 8, end: 8, bottom: 4),
                          child: Row(
                            children: [
                              CustomNetworkImage(
                                professor.image!,
                                width: 40,
                                height: 40,
                                radius: MyTheme.radiusSecondary,
                                onTap: () {
                                  context.push(TeacherScreen(professorId: professor.id!));
                                },
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      professor.name!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: context.colorPalette.black33,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "${professor.interviewHourPrice!.toStringAsFixed(1)} ${MySharedPreferences.user.currencySympol ?? "\$"} ${context.appLocalization.theHour}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                          child: CustomSvg(MyIcons.star),
                                        ),
                                        Text(
                                          professor.reviewsRating!.toStringAsFixed(1),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        if (professor.subjects!.isNotEmpty &&
                            professor.interviewDays!.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              context.authProvider.checkIfUserAuthenticated(
                                  context, callback: () {
                                context.push(BookingLectureScreen(teacherData: professor));
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: 22,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: context.colorPalette.blue8DD,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(MyTheme.radiusSecondary),
                                  bottomRight: Radius.circular(MyTheme.radiusSecondary),
                                ),
                              ),
                              child: Text(
                                context.appLocalization.bookNow,
                                style: TextStyle(
                                  color: context.colorPalette.black33,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
  @override
  bool get wantKeepAlive => true;
}
