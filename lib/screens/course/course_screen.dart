import 'package:bebrain/alerts/errors/app_error_feedback.dart';
import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/helper/purchases_service.dart';
import 'package:bebrain/helper/ui_helper.dart';
import 'package:bebrain/model/course_filter_model.dart';
import 'package:bebrain/model/subscriptions_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/course/widgets/content_card.dart';
import 'package:bebrain/screens/course/widgets/course_info.dart';
import 'package:bebrain/screens/course/widgets/course_nav_bar.dart';
import 'package:bebrain/screens/course/widgets/course_rate.dart';
import 'package:bebrain/screens/course/widgets/course_review.dart';
import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/screens/course/widgets/leading_back.dart';
import 'package:bebrain/screens/course/widgets/lecture_card.dart';
import 'package:bebrain/screens/course/widgets/rating_card.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/courses_list.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:bebrain/widgets/view_ratings_button.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatefulWidget {
  final int courseId;
  const CourseScreen({super.key, required this.courseId});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late MainProvider _mainProvider;
  late Future<CourseFilterModel> _courseFuture;
  String? _orderNumber;

  void _initializeFuture() async {
    _courseFuture = _mainProvider.filterByCourse(widget.courseId);
    final course = await _courseFuture;
    _orderNumber = course.data!.course!.subscription?[0].order?.orderNumber;
  }

  bool checkTime(DateTime firstDate, DateTime lastDate) {
    return (firstDate.toUTC(context).compareTo(DateTime.now()) == 0 ||
            DateTime.now().isAfter(firstDate.toUTC(context))) &&
        (lastDate.toUTC(context).compareTo(DateTime.now()) == 0 ||
            DateTime.now().isBefore(lastDate.toUTC(context)));
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
    _mainProvider = context.mainProvider;
    _initializeFuture();
    PurchasesService.initialize(
      onPurchase: () {
        UiHelper.confirmPayment(context, orderNumber: _orderNumber!,
            afterPay: () {
          setState(() {
            _initializeFuture();
          });
        });
      },
    );
  }

  @override
  void dispose() {
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
          bottomNavigationBar: course.paymentStatus == PaymentStatus.unPaid && course.price != 0 && course.discountPrice != 0
              ? CourseNavBar(
                  offer: course.offer,
                  price: course.price!,
                  discountPrice: course.discountPrice,
                  onTap: () {
                    if (course.available == 0) {
                      context.dialogNotAvailble();
                    } else {
                      UiHelper.payment(
                        context,
                        title: course.name!,
                        discription: course.description,
                        amount: course.discountPrice ?? course.price!,
                        id: course.id!,
                        orderId: course.subscription!.isEmpty || course.subscription == null
                            ? null
                            : course.subscription?[0].order?.orderNumber,
                        orderType: OrderType.subscription,
                        productId: course.productId,
                        subscribtionId: course.subscription!.isEmpty || course.subscription == null
                            ? null
                            : course.subscription?[0].id,
                        subscriptionsType: SubscriptionsType.course,
                        afterPay: (){
                          setState(() {
                            _initializeFuture();
                          });
                        },
                      );
                    }
                  },
                )
                : null,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                scrolledUnderElevation: 0,
                collapsedHeight: kBarCollapsedHeight,
                leading: const LeadingBack(),
                flexibleSpace: CustomNetworkImage(
                  course.image!,
                  height: 258,
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
                      if (course.subscription!.isEmpty)
                        StretchedButton(
                          onPressed: () {
                            if (course.available == 0) {
                              context.dialogNotAvailble();
                            } else {
                              _courseSubscribe(course.id!);
                            }
                          },
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            children: [
                              CourseText(
                                context.appLocalization.join,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                textColor: context.colorPalette.black33,
                              ),
                              CourseText(
                                context.appLocalization.getPatFree,
                                fontSize: 12,
                                textColor: context.colorPalette.black33,
                              ),
                            ],
                          ),
                        ),
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
                      LectureCard(professor: course.professor!),
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
              if (data.data!.moreCourses!.isNotEmpty)
                SliverToBoxAdapter(
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
                          courses: data.data!.moreCourses!,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
