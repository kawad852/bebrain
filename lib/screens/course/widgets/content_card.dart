import 'package:bebrain/model/course_filter_model.dart';
import 'package:bebrain/screens/course/unit_screen.dart';
import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  final Unit unit;
  const ContentCard({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push(UnitScreen(unitId: unit.id!));
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
            const CustomSvg(MyIcons.lock), //un lock
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
            Column(
              /// مجاناوتم الاشتراك
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(unit.discountPrice!=null)
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
