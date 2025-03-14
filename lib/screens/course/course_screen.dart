import 'package:bebrain/alerts/errors/app_error_feedback.dart';
import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/helper/purchases_service.dart';
import 'package:bebrain/helper/ui_helper.dart';
import 'package:bebrain/model/course_info_model.dart';
import 'package:bebrain/model/more_course_model.dart';
import 'package:bebrain/model/subscriptions_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/course/exam_screen.dart';
import 'package:bebrain/screens/course/widgets/content_card.dart';
import 'package:bebrain/screens/course/widgets/course_info.dart';
import 'package:bebrain/screens/course/widgets/course_nav_bar.dart';
import 'package:bebrain/screens/course/widgets/course_rate.dart';
import 'package:bebrain/screens/course/widgets/course_review.dart';
import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/screens/course/widgets/leading_back.dart';
import 'package:bebrain/screens/course/widgets/lecture_card.dart';
import 'package:bebrain/screens/course/widgets/rating_card.dart';
import 'package:bebrain/screens/vimeo_player/vimeo_player_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/widgets/courses_list.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/view_ratings_button.dart';
import 'package:flutter/material.dart';
import 'package:no_screenshot/no_screenshot.dart';

class CourseScreen extends StatefulWidget {
  final int courseId;
  const CourseScreen({super.key, required this.courseId});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late MainProvider _mainProvider;
  late Future<CourseInfoModel> _courseFuture;
  late Future<MoreCourseModel> _moreCourseFuture;
  String? _orderNumber;
  final _noScreenshot = NoScreenshot.instance;

  void _initializeMoreCourse() async {
    _moreCourseFuture = _mainProvider.fetchMoreCourse(widget.courseId);
  }

  void _initializeFuture() async {
    _courseFuture = _mainProvider.getCourseInfo(widget.courseId);
    final course = await _courseFuture;
    _orderNumber = course.data!.course!.subscription?[0].order?.orderNumber;
  }

  bool checkTime(DateTime firstDate, DateTime lastDate) {
    return (firstDate.toUTC(context).compareTo(DateTime.now()) == 0 || DateTime.now().isAfter(firstDate.toUTC(context))) &&
        (lastDate.toUTC(context).compareTo(DateTime.now()) == 0 || DateTime.now().isBefore(lastDate.toUTC(context)));
  }

  void disableScreenshot() async {
    if (!MySharedPreferences.canScreenshot) {
      bool result = await _noScreenshot.screenshotOff();
      debugPrint('Screenshot Off: $result');
    }
  }

  void enableScreenshot() async {
    if (!MySharedPreferences.canScreenshot) {
      bool result = await _noScreenshot.screenshotOn();
      debugPrint('Enable Screenshot: $result');
    }
  }

  void _courseSubscribe(int id) {
    ApiFutureBuilder<SubscriptionsModel>().fetch(
      context,
      future: () async {
        final subscribe = _mainProvider.subscribe(
          type: SubscriptionsType.course,
          id: id,
        );
        return subscribe;
      },
      onComplete: (snapshot) {
        if (snapshot.code == 200) {
          setState(() {
            _initializeFuture();
          });
        }
      },
      onError: (failure) => AppErrorFeedback.show(context, failure),
    );
  }

  @override
  void initState() {
    super.initState();
    // ScreenShotService.disableScreenshot();
    disableScreenshot();
    _mainProvider = context.mainProvider;
    _initializeFuture();
    _initializeMoreCourse();
    PurchasesService.initialize(
      onPurchase: () {
        UiHelper.confirmPayment(context, orderNumber: _orderNumber!, afterPay: () {
          setState(() {
            _initializeFuture();
          });
        });
      },
    );
  }

  @override
  void dispose() {
    // ScreenShotService.enableScreenshot();
    enableScreenshot();
    PurchasesService.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _courseFuture,
      withBackgroundColor: true,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onComplete: (context, snapshot) {
        final data = snapshot.data!;
        final course = data.data!.course!;
        return Scaffold(
          bottomNavigationBar: course.paymentStatus == PaymentStatus.unPaid
              //&& course.price != 0 && course.discountPrice != 0
              ? CourseNavBar(
                  offer: course.offer,
                  price: course.price!,
                  discountPrice: course.discountPrice,
                  onTap: () {
                    if (course.available == 0) {
                      context.dialogNotAvailble();
                    } else {
                      if (course.price == 0 || course.discountPrice == 0) {
                        context.paymentProvider.fakePayment(
                          context,
                          amount: course.discountPrice ?? course.price!,
                          orderType: OrderType.subscription,
                          productId: course.productId,
                          title: course.name!,
                          discription: course.description,
                          afterPay: () {
                            setState(() {
                              _initializeFuture();
                            });
                          },
                          id: course.id!,
                          orderId: course.subscription!.isEmpty || course.subscription == null ? null : course.subscription?[0].order?.orderNumber,
                          subscribtionId: course.subscription!.isEmpty || course.subscription == null ? null : course.subscription?[0].id,
                          subscriptionsType: SubscriptionsType.course,
                        );
                      } else {
                        UiHelper.payment(
                          context,
                          title: course.name!,
                          discription: course.description,
                          amount: course.discountPrice ?? course.price!,
                          id: course.id!,
                          orderId: course.subscription!.isEmpty || course.subscription == null ? null : course.subscription?[0].order?.orderNumber,
                          orderType: OrderType.subscription,
                          productId: course.productId,
                          subscribtionId: course.subscription!.isEmpty || course.subscription == null ? null : course.subscription?[0].id,
                          subscriptionsType: SubscriptionsType.course,
                          afterPay: () {
                            setState(() {
                              _initializeFuture();
                            });
                          },
                        );
                      }
                    }
                  },
                )
              : null,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                scrolledUnderElevation: 0,
                collapsedHeight: 170,
                leading: const LeadingBack(),
                flexibleSpace: course.freeVimeoId != null
                ? VimeoPlayerScreen(
                          vimeoId: course.freeVimeoId!,
                          videoId: course.freeVideoId,
                          isFullScreen: false,
                          isInitialize: false,
                          autoPlay: course.autoPlay!,
                        )
                : CustomNetworkImage(
                  course.image!,
                  radius: 0,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: CourseText(
                              course.name!,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ViewRatingsButton(
                            onTap: () {
                              context.showBottomSheet(
                                context,
                                builder: (context) {
                                  return CourseReview(courseId: course.id!);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 7),
                        child: Row(
                          children: [
                            Expanded(
                              child: CourseText(
                                course.university ?? "",
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14,
                                textColor: context.colorPalette.grey66,
                              ),
                            ),
                            Row(
                              children: [
                                const CustomSvg(MyIcons.star),
                                const SizedBox(width: 5),
                                CourseText(
                                  "( ${course.reviewsCount} ) ${course.reviewsRating!.toStringAsFixed(1)}",
                                  textColor: context.colorPalette.grey66,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      CourseText(
                        course.description!,
                      ),
                      const SizedBox(height: 10),
                      if (course.isSubscribed == 1)
                        CourseRate(
                          courseName: course.name!,
                          courseId: course.id!,
                        ),
                      CourseInfo(
                        hours: course.hours!,
                        minutes: course.minutes!,
                        videoCount: course.videosCount!,
                        subscriptionCount: course.subscriptionCount!,
                      ),
                      // if (course.subscription!.isEmpty)
                      //   StretchedButton(
                      //     onPressed: () {
                      //       if (course.available == 0) {
                      //         context.dialogNotAvailble();
                      //       } else {
                      //         _courseSubscribe(course.id!);
                      //       }
                      //     },
                      //     margin: const EdgeInsets.symmetric(vertical: 12),
                      //     child: Column(
                      //       children: [
                      //         CourseText(
                      //           context.appLocalization.join,
                      //           fontSize: 15,
                      //           fontWeight: FontWeight.bold,
                      //           textColor: context.colorPalette.black33,
                      //         ),
                      //         CourseText(
                      //           context.appLocalization.getPatFree,
                      //           fontSize: 12,
                      //           textColor: context.colorPalette.black33,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      CourseText(
                        context.appLocalization.contents,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverList.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                  itemCount: course.units!.length,
                  itemBuilder: (context, index) {
                    return ContentCard(
                      unit: course.units![index],
                      unitStatus: course.units![index].paymentStatus!,
                      productId: course.productId,
                      available: course.available!,
                      isSubscribedCourse: course.subscription!.isNotEmpty,
                      subscriptionCourse: course.subscription,
                      courseImage: course.image!,
                      afterNavigate: () {
                        setState(() {
                          _initializeFuture();
                        });
                      },
                    );
                  },
                ),
              ),
              SliverPadding(
                padding: const EdgeInsetsDirectional.only(start: 15, end: 15, top: 5),
                sliver: SliverList.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                  itemCount: course.exams!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: context.colorPalette.greyEEE,
                        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                      ),
                      child: Row(
                        children: [
                          CustomSvg(
                            course.exams![index].paymentType == 0 || (course.paymentStatus == 1 && course.exams![index].paymentType == 1)
                                ? MyIcons.examOpen
                                : MyIcons.examClose,
                          ),
                          const SizedBox(width: 7),
                          Expanded(
                            child: CourseText(
                              course.exams![index].name!,
                              maxLines: 2,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          GestureDetector(
                            onTap: course.exams![index].paymentType == 0 || (course.paymentStatus == 1 && course.exams![index].paymentType == 1)
                                ? () {
                                    context.push(ExamScreen(payUrl: course.exams![index].link!));
                                  }
                                : null,
                            child: Container(
                              height: 23,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: course.exams![index].paymentType == 0 || (course.paymentStatus == 1 && course.exams![index].paymentType == 1)
                                    ? context.colorPalette.blue8DD
                                    : context.colorPalette.greyD9D,
                                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                              ),
                              child: Text(
                                context.appLocalization.go,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: context.colorPalette.black33,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CourseText(
                        context.appLocalization.aboutTheTeacher,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      LectureCard(courseId: course.id!),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CourseText(
                            context.appLocalization.ratings,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          ViewRatingsButton(
                            onTap: () {
                              context.showBottomSheet(
                                context,
                                builder: (context) {
                                  return CourseReview(courseId: course.id!);
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
                            child: CourseText(
                              "5/${course.reviewsRating!.toStringAsFixed(1)}",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CourseText(
                            context.appLocalization.basedOnRatings("${course.reviewsCount}"),
                            fontSize: 12,
                          ),
                        ],
                      ),
                      RatingCard(
                        audioVideoRating: course.audioVideoQuality!,
                        conveyIdea: course.conveyIdea!,
                        valueForMoney: course.valueForMoney!,
                        similarityCurriculumContent: course.similarityCurriculumContent!,
                      ),
                    ],
                  ),
                ),
              ),
              // if (data.data!.moreCourses!.isNotEmpty)
                CustomFutureBuilder(
                  future: _moreCourseFuture,
                  sliver: true,
                  onRetry: () {
                    setState(() {
                      _initializeMoreCourse();
                    });
                  },
                  onComplete: (context, snapshot) {
                    final moreCourse = snapshot.data!;
                    return moreCourse.data!.moreCourses!.isEmpty
                    ? const SliverToBoxAdapter(
                      child: SizedBox.shrink(),
                    )
                    :SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: CourseText(
                              context.appLocalization.more,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: CoursesList(
                              courses: moreCourse.data!.moreCourses!,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
