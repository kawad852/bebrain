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
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  final int available;
  final bool isSubscribedCourse;
  final Unit unit;
  final List<SubscriptionsData>? subscriptionCourse;
  final void Function() afterNavigate;
  const ContentCard(
      {super.key,
      required this.unit,
      required this.available,
      required this.isSubscribedCourse, 
      required this.subscriptionCourse, 
      required this.afterNavigate,
      });

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
              unit.type == PaymentType.free || unit.paymentStatus == PaymentStatus.paid
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
                              "\$${unit.unitPrice}",
                              textColor: context.colorPalette.grey66,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          CourseText(
                            "\$${unit.discountPrice ?? unit.unitPrice}",
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
