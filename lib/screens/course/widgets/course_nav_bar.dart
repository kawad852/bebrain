import 'package:bebrain/model/course_filter_model.dart';
import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CourseNavBar extends StatefulWidget {
  final Offer? offer;
  final double price;
  final double? discountPrice;
  final void Function() onTap;
  const CourseNavBar({
    super.key,
    required this.offer,
    required this.price,
    required this.discountPrice, 
    required this.onTap,
  });

  @override
  State<CourseNavBar> createState() => _CourseNavBarState();
}

class _CourseNavBarState extends State<CourseNavBar> {
  Duration difference = const Duration(days: 0, hours: 0, minutes: 0, seconds: 0);


  @override
  void initState() {
    super.initState();
    if(widget.offer != null){
    difference = widget.offer!.endDate!.toUTC(context).difference(DateTime.now());
    }  
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        height: 66,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: context.colorPalette.blueC2E,
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.discountPrice != null)
                  CourseText(
                    "${MySharedPreferences.user.currencySympol} ${widget.price}",
                    fontSize: 16,
                    textColor: context.colorPalette.grey66,
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.bold,
                  ),
                CourseText(
                  "${MySharedPreferences.user.currencySympol} ${widget.discountPrice ?? widget.price}",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CourseText(
                    widget.offer?.content?? context.appLocalization.buyFullCourse,
                    // context.appLocalization.discountEntireCourse(70),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    fontWeight: FontWeight.bold,
                  ),
                  if(widget.offer != null)
                  TweenAnimationBuilder<Duration>(
                    duration: difference,
                    tween: Tween(begin: difference, end: Duration.zero),
                    builder:(BuildContext context, Duration value, Widget? child) {
                      final days = value.inDays;
                      final hours = value.inHours.remainder(24);
                      final minutes = value.inMinutes.remainder(60);
                      final seconds = value.inSeconds.remainder(60);
                      return CourseText(
                        "$seconds ${context.appLocalization.second}, $minutes ${context.appLocalization.minute}, $hours ${context.appLocalization.hours}, $days ${context.appLocalization.days}",
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                        textColor: context.colorPalette.grey66,
                      );
                    },
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: widget.onTap,
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
