import 'package:bebrain/model/unit_filter_model.dart';
import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

class PartCard extends StatelessWidget {
  final Section section;
  const PartCard({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      child: ExpansionTile(
        shape: const Border(),
        backgroundColor: context.colorPalette.greyEEE,
        collapsedBackgroundColor: context.colorPalette.greyEEE,
        trailing: Column(
          /// مجاناوتم الاشتراك
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(section.discountPrice!=0)
            CourseText(
              "\$${section.discountPrice}",
              textColor: context.colorPalette.grey66,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.lineThrough,
            ),
             CourseText(
              "\$${section.sectionPrice}",
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        title: Row(
          children: [
            const CustomSvg(MyIcons.lock), //un lock
            const SizedBox(width: 7),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   CourseText(
                   section.name!,
                    fontWeight: FontWeight.bold,
                  ),
                  CourseText(
                    "${section.numberOfMinutes} ${context.appLocalization.minute} , ${section.videosCount} ${context.appLocalization.videos} , ${section.documentsCount} ${context.appLocalization.file}",
                    textColor: context.colorPalette.grey66,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
        children: [
          ...section.videos!.map((element){
            return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Row(
              children: [
                const CustomSvg(MyIcons.playCircle),
                const SizedBox(width: 7),
                 Expanded(
                  child: CourseText(
                    element.name!,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CourseText(
                  "00:39",
                  fontSize: 12,
                  textColor: context.colorPalette.grey66,
                ),
              ],
            ),
          );
          }).toList(),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colorPalette.blueC2E,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(MyTheme.radiusSecondary),
                  bottomRight: Radius.circular(MyTheme.radiusSecondary),
                ),
              ),
              child: CourseText(
                context.appLocalization.subscribeSection,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
