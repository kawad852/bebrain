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
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:flutter/material.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class UnitScreen extends StatefulWidget {
  final int unitId;
  final bool isSubscribedCourse;
  final int available;
  final List<SubscriptionsData>? subscriptionCourse;
  const UnitScreen({
    super.key, 
    required this.unitId, 
    required this.isSubscribedCourse, 
    required this.available, 
    required this.subscriptionCourse,
    });

  @override
  State<UnitScreen> createState() => _UnitScreenState();
}

class _UnitScreenState extends State<UnitScreen> {
  
  late MainProvider _mainProvider;
  late Future<UnitFilterModel> _unitFuture;

  void _initializeFuture() async {
    _unitFuture = _mainProvider.filterByUnit(widget.unitId);
  }

  bool checkTime(DateTime firstDate, DateTime lastDate){
    return (firstDate.toUTC(context).compareTo(DateTime.now())==0 ||  DateTime.now().isAfter(firstDate.toUTC(context))) &&
      (lastDate.toUTC(context).compareTo(DateTime.now())==0 ||  DateTime.now().isBefore(lastDate.toUTC(context)));
  }

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
    _initializeFuture();
    
  }

  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _unitFuture,
      withBackgroundColor: true,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onComplete: (context, snapshot) {
        final data=snapshot.data!;
        final unit=data.data!;
        return Scaffold(
          bottomNavigationBar: unit.courseOffer==null || !checkTime(unit.courseOffer!.startDate!,unit.courseOffer!.endDate!) || unit.courseOffer == null
         ? null 
          : CourseNavBar(
            offer: unit.courseOffer!,
            price: unit.couursePrice!,
            discountPrice: unit.courseDiscountPrice,
            onTap: (){
              if(widget.available == 0){
                context.dialogNotAvailble();
              } else{
                context.paymentProvider.pay(
                  context,
                  id: unit.courseId!,
                  amount: unit.courseDiscountPrice?? unit.couursePrice!,
                  orderType: OrderType.subscription,
                  subscriptionsType: SubscriptionsType.course,
                  subscribtionId: widget.subscriptionCourse!.isEmpty || widget.subscriptionCourse == null
                  ? null
                  : widget.subscriptionCourse?[0].id,
                  orderId: widget.subscriptionCourse!.isEmpty || widget.subscriptionCourse == null
                  ? null
                  : widget.subscriptionCourse?[0].order?.orderNumber,
                  afterPay: (){
                    setState(() {
                      _initializeFuture();
                   });
                  },
                );
              }
            },
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                scrolledUnderElevation: 0,
                collapsedHeight: 170,
                leading: const LeadingBack(),
                flexibleSpace:VimeoPlayerScreen(
                vimeoId: unit.sections![0].videos![0].vimeoId!,
              ),
              ),
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
                              if(unit.discountPrice!=null)
                              CourseText(
                                "\$${unit.unitPrice}",
                                textColor: context.colorPalette.grey66,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.bold,
                              ),
                               CourseText(
                                "\$${unit.discountPrice?? unit.unitPrice}",
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
                     if(unit.paymentStatus == PaymentStatus.unPaid)
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
                                if(unit.discountPrice!=null)
                                CourseText(
                                  "\$${unit.unitPrice}",
                                  textColor: context.colorPalette.grey66,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.bold,
                                ),
                                CourseText(
                                  "\$${unit.discountPrice?? unit.unitPrice}",
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
                              onTap: (){
                                 if(widget.available == 0){
                                    context.dialogNotAvailble();
                                 }
                                 else {
                                  context.paymentProvider.pay(
                                    context, 
                                    id: unit.id!, 
                                    amount: unit.discountPrice?? unit.unitPrice!, 
                                    orderType: OrderType.subscription,
                                    subscriptionsType: SubscriptionsType.unit,
                                    orderId: unit.subscription!.isEmpty || unit.subscription == null
                                    ? null
                                    : unit.subscription?[0].order?.orderNumber,
                                    subscribtionId: unit.subscription!.isEmpty || unit.subscription == null
                                    ? null
                                    : unit.subscription?[0].id ,
                                    afterPay: (){
                                      setState(() {
                                         _initializeFuture();
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                sliver: SliverList.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                  itemCount: unit.sections!.length,
                  itemBuilder: (context, index) {
                    final section = unit.sections![index];
                    return  PartCard(
                      section: section,
                      isSubscribedCourse: widget.isSubscribedCourse,
                      onTap: (){
                        widget.available == 0
                        ? context.dialogNotAvailble()
                        : context.paymentProvider.pay(
                          context, 
                          id: section.id!, 
                          amount: section.discountPrice?? section.sectionPrice!, 
                          orderType: OrderType.subscription,
                          orderId: section.subscription!.isEmpty || section.subscription == null
                          ? null 
                          : section.subscription?[0].order?.orderNumber,
                          subscribtionId: section.subscription!.isEmpty || section.subscription == null
                          ? null
                          : section.subscription?[0].id,
                          subscriptionsType: SubscriptionsType.section,
                          afterPay: (){
                            setState(() {
                              _initializeFuture();
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
