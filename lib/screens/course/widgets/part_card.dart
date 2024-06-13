import 'package:bebrain/model/unit_filter_model.dart';
import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/screens/file/file_screen.dart';
import 'package:bebrain/screens/video/video_screen.dart';
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
            if (section.discountPrice != null)
              CourseText(
                "\$${section.sectionPrice}",
                textColor: context.colorPalette.grey66,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.lineThrough,
              ),
            CourseText(
              "\$${section.discountPrice?? section.sectionPrice}",
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
          ...section.videos!.map((element) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      context.push(VideoScreen(videoId: element.vimeoId!));
                    },
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
                          "${element.period} ${context.appLocalization.minute}",
                          fontSize: 12,
                          textColor: context.colorPalette.grey66,
                        ),
                      ],
                    ),
                  ),
                  if (element.document != null) const SizedBox(height: 5),
                  if (element.document != null)
                    GestureDetector(
                      onTap: () {
                        context.push(
                          FileScreen(
                            url: element.document!,
                            fileName: element.name!,
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const CustomSvg(MyIcons.attach),
                          const SizedBox(width: 7),
                          Expanded(
                            child: CourseText(
                              "${element.name!} (${context.appLocalization.attachedFile})",
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
          ...section.documents!.map((document) {
            return GestureDetector(
              onTap: () {
                context.push(
                  FileScreen(
                    url: document.document!,
                    fileName: document.name!,
                  ),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    const CustomSvg(MyIcons.attach),
                    const SizedBox(width: 7),
                    Expanded(
                      child: CourseText(
                        "${document.name!} (${context.appLocalization.attachedFile})",
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
