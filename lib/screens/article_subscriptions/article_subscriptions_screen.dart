import 'package:bebrain/model/user_subscription_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/course/course_screen.dart';
import 'package:bebrain/screens/department/widgets/text_course.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/evaluation_star.dart';
import 'package:bebrain/widgets/shimmer/shimmer_bubble.dart';
import 'package:bebrain/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticleSubscriptionsScreen extends StatefulWidget {
  const ArticleSubscriptionsScreen({super.key});

  @override
  State<ArticleSubscriptionsScreen> createState() =>_ArticleSubscriptionsScreenState();
}

class _ArticleSubscriptionsScreenState extends State<ArticleSubscriptionsScreen> {
  late MainProvider _mainProvider;
  late Future<UserSubscriptionModel> _userSubscriptionFuture;

  void _initializeFuture() async {
    _userSubscriptionFuture = _mainProvider.fetchMySubscription();
  }

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
    _initializeFuture();
  }

   bool checkTime(DateTime date){
    return (date.toUTC(context).compareTo(DateTime.now())==0 ||  DateTime.now().isBefore(date.toUTC(context)));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(pinned: true),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Text(
                context.appLocalization.articleSubscriptions,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          CustomFutureBuilder(
            future: _userSubscriptionFuture,
            sliver: true,
            onRetry: (){
              setState(() {
                _initializeFuture();
              });
            },
            onLoading: (){
              return ShimmerLoading(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  itemCount:10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return const LoadingBubble(
                      width: double.infinity,
                      height: 110,
                      padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      radius: MyTheme.radiusSecondary,
                    );
                  },

                ),
                );
            },
            onComplete: (context,snapshot) {
              final mySubscription = snapshot.data!;
              return mySubscription.data!.isEmpty
              ? SliverFillRemaining(
                child: Center(child: Text(context.appLocalization.dontHaveSubscription)),
              ) 
            : SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: mySubscription.data!.length,
              itemBuilder: (context, index) {
                final subscription = mySubscription.data![index];
                return GestureDetector(
                  onTap: () => context.push(CourseScreen(courseId: subscription.id!)),
                  child: Container(
                    width: double.infinity,
                    height: 110,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? context.colorPalette.blueE4F
                          : context.colorPalette.greyF2F,
                      borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                      border: Border.all(
                        color: context.colorPalette.greyF2F,
                      ),
                    ),
                    child: Row(
                      children: [
                        CustomNetworkImage(
                          subscription.image!,
                          width: 90,
                          height: 90,
                          radius: MyTheme.radiusSecondary,
                          alignment: context.isLTR ? Alignment.topLeft : Alignment.topRight,
                          child:  EvaluationStar(
                            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            evaluation: subscription.reviewsRating!.toStringAsFixed(1),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCourse(
                               subscription.name!,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: context.colorPalette.black33,
                              ),
                               TextCourse(
                               subscription.professor!,
                                fontSize: 14,
                              ),
                              TextCourse(
                                checkTime(subscription.subscriptions![0].period!.to!)
                                ? "${context.appLocalization.subscriptionActiveUntil} ${DateFormat("dd/MM/yyyy").format(subscription.subscriptions![0].period!.to!)}"
                                : "${context.appLocalization.subscriptionEnded} ${DateFormat("dd/MM/yyyy").format(subscription.subscriptions![0].period!.to!)}" ,
                                color: checkTime(subscription.subscriptions![0].period!.to!)
                                ? context.colorPalette.green008
                                : context.colorPalette.redE42,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const CustomSvg(MyIcons.video),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(start: 5, end: 8),
                                    child: TextCourse("${subscription.videosCount} ${context.appLocalization.video}"),
                                  ),
                                  const CustomSvg(MyIcons.axes),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(start: 5),
                                    child: TextCourse("${subscription.unitsCount} ${context.appLocalization.axes}"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
            },
          ),
        ],
      ),
    );
  }
}
