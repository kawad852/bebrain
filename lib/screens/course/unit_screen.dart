import 'dart:developer';

import 'package:bebrain/helper/purchases_service.dart';
import 'package:bebrain/helper/ui_helper.dart';
import 'package:bebrain/model/subscriptions_model.dart';
import 'package:bebrain/model/unit_filter_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/course/widgets/course_nav_bar.dart';
import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/screens/course/widgets/leading_back.dart';
import 'package:bebrain/screens/course/widgets/part_card.dart';
import 'package:bebrain/screens/vimeo_player/vimeo_player_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_screenshot/no_screenshot.dart';

class UnitScreen extends StatefulWidget {
  final int unitId;
  final bool isSubscribedCourse;
  final int available;
  final String courseImage;
  final String? productIdCourse;
  final List<SubscriptionsData>? subscriptionCourse;
  const UnitScreen({
    super.key,
    required this.unitId,
    required this.isSubscribedCourse,
    required this.available,
    required this.subscriptionCourse,
    required this.courseImage, 
    required this.productIdCourse,
  });

  @override
  State<UnitScreen> createState() => _UnitScreenState();
}

class _UnitScreenState extends State<UnitScreen> {
  final _noScreenshot = NoScreenshot.instance;
  late MainProvider _mainProvider;
  late Future<UnitFilterModel> _unitFuture;
  String? _orderNumber;

  _initializeFuture(String? type, int? index ) async {
    _unitFuture = _mainProvider.filterByUnit(widget.unitId);
    final _unit = await _unitFuture;
    switch(type){
      case SubscriptionsType.course:
        _orderNumber = _unit.data!.courseSubscription?[0].order?.orderNumber;
      case SubscriptionsType.unit:
        _orderNumber = _unit.data!.subscription?[0].order?.orderNumber;
      case SubscriptionsType.section:
        _orderNumber = _unit.data!.sections?[index!].subscription?[0].order?.orderNumber;
     }
    log(_orderNumber.toString());
  }

  bool checkTime(DateTime firstDate, DateTime lastDate) {
    return (firstDate.toUTC(context).compareTo(DateTime.now()) == 0 ||
            DateTime.now().isAfter(firstDate.toUTC(context))) &&
        (lastDate.toUTC(context).compareTo(DateTime.now()) == 0 || DateTime.now().isBefore(lastDate.toUTC(context)));
  }

  void disableScreenshot() async {
    bool result = await _noScreenshot.screenshotOff();
    debugPrint('Screenshot Off: $result');
  }

  void enableScreenshot() async {
    bool result = await _noScreenshot.screenshotOn();
    debugPrint('Enable Screenshot: $result');
  }

  @override
  void initState() {
    super.initState();
    disableScreenshot();
    _mainProvider = context.mainProvider;
    _initializeFuture(null,null);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    PurchasesService.initialize(
      onPurchase: () {
        UiHelper.confirmPayment(
          context, 
          orderNumber: _orderNumber!,
          afterPay: (){
            setState(() {
              _initializeFuture(null , null);
            });
          }
          );
      },
    );
  }

  @override
  void dispose() {
    enableScreenshot();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    PurchasesService.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _unitFuture,
      withBackgroundColor: true,
      onRetry: () {
        setState(() {
          _initializeFuture(null ,null);
        });
      },
      onComplete: (context, snapshot) {
        final data = snapshot.data!;
        final unit = data.data!;
        return Scaffold(
          bottomNavigationBar:
              unit.courseOffer != null && unit.couursePrice != 0 && unit.courseDiscountPrice != 0
                  ? CourseNavBar(
                      offer: unit.courseOffer!,
                      price: unit.couursePrice!,
                      discountPrice: unit.courseDiscountPrice,
                      onTap: () {
                        if (widget.available == 0) {
                          context.dialogNotAvailble();
                        } else {
                          UiHelper.payment(
                            context,
                            title: unit.courseName! ,
                            amount: unit.courseDiscountPrice ?? unit.couursePrice!,
                            id: unit.courseId!,
                            orderId: unit.courseSubscription!.isEmpty || unit.courseSubscription == null
                                ? null
                                : unit.courseSubscription?[0].order?.orderNumber,
                            orderType: OrderType.subscription,
                            productId: widget.productIdCourse,
                            subscribtionId: unit.courseSubscription!.isEmpty || unit.courseSubscription == null
                                ? null
                                : unit.courseSubscription?[0].id,
                            subscriptionsType: SubscriptionsType.course,
                            afterPay: (){
                              setState(() {
                                _initializeFuture(SubscriptionsType.course, 0);
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
                  collapsedHeight: 170,
                  leading: const LeadingBack(),
                  flexibleSpace: (widget.isSubscribedCourse && unit.type == PaymentType.free) || (unit.paymentStatus == PaymentStatus.paid && unit.type == PaymentType.notFree)
                      ? VimeoPlayerScreen(
                          vimeoId: unit.sections![0].videos![0].vimeoId!,
                          videoId: unit.sections![0].videos![0].id!,
                        )
                      : CustomNetworkImage(
                          widget.courseImage,
                          radius: 0,
                        )),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          Expanded(
                            child: CourseText(
                              unit.name!,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            children: [
                              if (unit.discountPrice != null)
                                CourseText(
                                  "${MySharedPreferences.user.currencySympol} ${unit.unitPrice}",
                                  textColor: context.colorPalette.grey66,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.bold,
                                ),
                              CourseText(
                                "${MySharedPreferences.user.currencySympol} ${unit.discountPrice ?? unit.unitPrice}",
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                      CourseText(
                        unit.courseName!,
                        textColor: context.colorPalette.grey66,
                        fontWeight: FontWeight.bold,
                      ),
                      if (unit.paymentStatus == PaymentStatus.unPaid && unit.unitPrice != 0 && unit.discountPrice != 0 && unit.type == PaymentType.notFree)
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: context.colorPalette.blueC2E,
                            borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (unit.discountPrice != null)
                                    CourseText(
                                      "${MySharedPreferences.user.currencySympol} ${unit.unitPrice}",
                                      textColor: context.colorPalette.grey66,
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  CourseText(
                                    "${MySharedPreferences.user.currencySympol} ${unit.discountPrice ?? unit.unitPrice}",
                                    textColor: context.colorPalette.black33,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              CourseText(
                                context.appLocalization.subscribeToThisPartOnly,
                                fontWeight: FontWeight.bold,
                                textColor: context.colorPalette.black33,
                              ),
                              GestureDetector(
                                onTap: ()async {
                                  if (widget.available == 0) {
                                    context.dialogNotAvailble();
                                  } else {
                                    UiHelper.payment(
                                      context,
                                      title: unit.name!,
                                      amount: unit.discountPrice?? unit.unitPrice!,
                                      id: unit.id!,
                                      orderId: unit.subscription!.isEmpty || unit.subscription == null
                                      ? null
                                      : unit.subscription?[0].order?.orderNumber,
                                      orderType: OrderType.subscription,
                                      productId: unit.productId,
                                      subscribtionId: unit.subscription!.isEmpty || unit.subscription == null
                                      ? null
                                      : unit.subscription?[0].id,
                                      subscriptionsType: SubscriptionsType.unit,
                                      afterPay: (){
                                        setState(() {
                                          _initializeFuture(SubscriptionsType.unit,0);
                                        });
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  width: 46,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: context.colorPalette.blue8DD,
                                    borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                                  ),
                                  child: CourseText(
                                    context.appLocalization.buying,
                                    textColor: context.colorPalette.black33,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                sliver: SliverList.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                  itemCount: unit.sections!.length,
                  itemBuilder: (context, index) {
                    final section = unit.sections![index];
                    return PartCard(
                      section: section,
                      unitStatus: unit.paymentStatus!,
                      isSubscribedCourse: widget.isSubscribedCourse,
                      onTap: () {
                        widget.available == 0
                            ? context.dialogNotAvailble()
                            : UiHelper.payment(
                              context,
                              title: section.name!,
                              amount: section.discountPrice ?? section.sectionPrice!,
                              id: section.id!,
                              orderId: section.subscription!.isEmpty || section.subscription == null
                                    ? null
                                    : section.subscription?[0].order?.orderNumber,
                              orderType: OrderType.subscription,
                              productId: section.productId,
                              subscribtionId: section.subscription!.isEmpty || section.subscription == null
                                    ? null
                                    : section.subscription?[0].id,
                              subscriptionsType: SubscriptionsType.section,
                              afterPay: (){
                                setState(() {
                                  _initializeFuture(SubscriptionsType.section, index);
                                });
                              },
                            );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
