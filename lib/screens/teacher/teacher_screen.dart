import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/model/teacher_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/teacher/widgets/rate_card.dart';
import 'package:bebrain/screens/teacher/widgets/teacher_card.dart';
import 'package:bebrain/screens/teacher/widgets/teacher_loading.dart';
import 'package:bebrain/screens/teacher/widgets/teacher_nav_bar.dart';
import 'package:bebrain/screens/teacher/widgets/teacher_reviews.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/courses_list.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/view_ratings_button.dart';
import 'package:flutter/material.dart';

class TeacherScreen extends StatefulWidget {
  final int professorId;
  const TeacherScreen({super.key, required this.professorId});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  late MainProvider _mainProvider;
  late Future<TeacherModel> _teacherFuture;

  void _initializeFuture() async {
    _teacherFuture = _mainProvider.fetchProfessorById(widget.professorId);
  }

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _teacherFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      withBackgroundColor: true,
      onLoading: () => const TeacherLoading(),
      onComplete: (context, snapshot) {
        final professor = snapshot.data!;
        return Scaffold(
          bottomNavigationBar: professor.data!.subjects!.isNotEmpty && professor.data!.interviewDays!.isNotEmpty? TeacherNavBar(teacherData: professor.data!) : null,
          body: RefreshIndicator(
            onRefresh: ()async{
              setState(() {
                _initializeFuture();
              });
            },
            child: CustomScrollView(
              slivers: [
                 SliverAppBar(
                  pinned: true,
                  collapsedHeight: 320,
                  flexibleSpace: TeacherCard(teacherData: professor.data!),
                ),
                if(professor.data!.subjects!.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.appLocalization.onlineLectures,
                          style: TextStyle(
                            color: context.colorPalette.black33,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          context.appLocalization.bookOnlineLecture,
                          style: TextStyle(
                            color: context.colorPalette.grey66,
                            fontSize: 12,
                          ),
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          children: professor.data!.subjects!.map((item){
                             return Row(
                              mainAxisSize: MainAxisSize.min,
                               children: [
                                 Container(
                                  height: 34,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  margin: const EdgeInsets.symmetric(horizontal: 2,vertical: 3),
                                  decoration: BoxDecoration(
                                    color: context.colorPalette.greyEEE,
                                    borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                                  ),
                                  child: Text(
                                    item.name!,
                                    style: TextStyle(
                                      color: context.colorPalette.grey66,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                 ),
                               ],
                             );
                          },
                          ).toList(),
                        ),

                      ],
                    ),
                  ),
                ),
                if(professor.data!.courses!.isNotEmpty)
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
                         CoursesList(
                          courses: professor.data!.courses!,
                        ),
                      ],
                    ),
                  ),
                ),
                if(professor.data!.reviews!.isNotEmpty)
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
                           ViewRatingsButton(
                            onTap: (){
                              context.showBottomSheet(context,
                               builder: (context){
                                return TeacherReviews(professorId: professor.data!.id!);
                              },
                            );
                          },
                         ),
                       ],
                      ),
                        Row(
                          children: [
                            const CustomSvg(MyIcons.star, width: 20),
                             Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "5/${professor.data!.reviewsRating!.toStringAsFixed(1)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              context.appLocalization.basedOnRatings("${professor.data!.reviewsCount}"),
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
                if(professor.data!.reviews!.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  sliver: SliverList.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemCount: professor.data!.reviews!.length,
                    itemBuilder: (context, index) {
                      return RateCard(review: professor.data!.reviews![index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
