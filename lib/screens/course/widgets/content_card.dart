import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/model/course_filter_model.dart';
import 'package:bebrain/model/subscriptions_model.dart';
import 'package:bebrain/screens/course/unit_screen.dart';
import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/screens/course/widgets/free_bubble.dart';
import 'package:bebrain/screens/course/widgets/subscribed_bubble.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  final int available;
  final bool isSubscribedCourse;
  final Unit unit;
  final String courseImage;
  final String? productId;
  final int unitStatus;
  final List<SubscriptionsData>? subscriptionCourse;
  final void Function() afterNavigate;
  const ContentCard(
      {super.key,
      required this.unit,
      required this.available,
      required this.isSubscribedCourse, 
      required this.subscriptionCourse, 
      required this.afterNavigate,
      required this.courseImage,
      required this.productId,
      required this.unitStatus,
      });

  bool get _allowShow => (isSubscribedCourse && unit.type == PaymentType.free) || (unit.paymentStatus == PaymentStatus.paid && unit.type == PaymentType.notFree) || ( unitStatus == PaymentStatus.paid );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        if (unit.videosCount == 0 && unit.documentsCount == 0) {
          context.showDialog(
            titleText: "",
            confirmTitle: context.appLocalization.back,
            bodyText: context.appLocalization.noContent,
          );
        } else {
         await context.push(
            UnitScreen(
              unitId: unit.id!,
              isSubscribedCourse: isSubscribedCourse,
              available: available,
              subscriptionCourse: subscriptionCourse,
              courseImage: courseImage,
              productIdCourse: productId,
            ),
          ).then((value){
            afterNavigate();
          });
        }
      },
      child: Container(
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
              _allowShow
             // unit.type == PaymentType.free || unit.paymentStatus == PaymentStatus.paid
                  ? MyIcons.unLock
                  : MyIcons.lock,
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CourseText(
                    unit.name!,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                  CourseText(
                    "${unit.videosMinutes} ${context.appLocalization.minute} , ${unit.videosCount} ${context.appLocalization.videos} , ${unit.documentsCount} ${context.appLocalization.file}",
                    textColor: context.colorPalette.grey66,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
            unit.type == PaymentType.free
                ? const FreeBubble()
                : unit.paymentStatus == PaymentStatus.paid
                    ? const SubscribedBubble()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (unit.discountPrice != null)
                            CourseText(
                              "${MySharedPreferences.user.currencySympol} ${unit.unitPrice}",
                              textColor: context.colorPalette.grey66,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          CourseText(
                            "${MySharedPreferences.user.currencySympol} ${unit.discountPrice ?? unit.unitPrice}",
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}
