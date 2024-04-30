import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/screens/course/widgets/point.dart';
import 'package:bebrain/utils/app_constants.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/more_button.dart';
import 'package:flutter/material.dart';

class LectureCard extends StatelessWidget {
  const LectureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 142,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: context.colorPalette.greyEEE,
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CustomNetworkImage(
                kFakeImage,
                width: 42,
                height: 42,
                radius: MyTheme.radiusSecondary,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: CourseText(
                            "د. عبدالله محمد",
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        MoreButton(onTap: () {}),
                      ],
                    ),
                    Container(
                      width: 46,
                      height: 20,
                      decoration: BoxDecoration(
                        color: context.colorPalette.white50,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomSvg(MyIcons.star),
                          SizedBox(width: 5),
                          CourseText(
                            "4.8",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CourseText(
                  "${context.appLocalization.views} 3.95M",
                  fontSize: 12,
                ),
                const Point(),
                CourseText(
                  "4950 ${context.appLocalization.subscriber}",
                  fontSize: 12,
                ),
                const Point(),
                CourseText(
                  "12 ${context.appLocalization.article}",
                  fontSize: 12,
                ),
              ],
            ),
          ),
          const Flexible(
            child: CourseText(
              "حاصل على شهادة دكتوراة في محاسبة الشركات وعضوا هيئة تدريسية في الجامعة الأردنية ومحاضر اكاديمي في جامعة الزيتونة الأردنية",
              fontSize: 12,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
