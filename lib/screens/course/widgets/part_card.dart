import 'package:bebrain/model/unit_filter_model.dart';
import 'package:bebrain/screens/course/exam_screen.dart';
import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/screens/course/widgets/free_bubble.dart';
import 'package:bebrain/screens/course/widgets/subscribed_bubble.dart';
import 'package:bebrain/screens/file/file_screen.dart';
import 'package:bebrain/screens/vimeo_player/vimeo_player_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

class PartCard extends StatelessWidget {
  final Section section;
  final bool isSubscribedCourse;
  final int unitStatus;
  final void Function() onTap;
  final Function(String viemoId, int videoId) onTapVideo;
  const PartCard({
    super.key, 
    required this.section, 
    required this.onTap, 
    required this.isSubscribedCourse, 
    required this.unitStatus,
    required this.onTapVideo,
    });

  bool get _sectionAllow => section.type == PaymentType.free || section.paymentStatus == PaymentStatus.paid;

  bool get _allowShow => (isSubscribedCourse && section.type == PaymentType.free) || (section.paymentStatus == PaymentStatus.paid && section.type == PaymentType.notFree) || ( unitStatus == PaymentStatus.paid );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      child: ExpansionTile(
        shape: const Border(),
        tilePadding: const EdgeInsets.symmetric(horizontal: 10),
        backgroundColor: context.colorPalette.greyEEE,
        collapsedBackgroundColor: context.colorPalette.greyEEE,
        trailing: section.type == PaymentType.notFree && section.sectionPrice == 0
        ? const  SizedBox.shrink() 
        : section.type == PaymentType.free
            ? const FreeBubble()
            : section.paymentStatus == PaymentStatus.paid
                ? const SubscribedBubble()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (section.discountPrice != null)
                        CourseText(
                          "${MySharedPreferences.user.currencySympol} ${section.sectionPrice}",
                          textColor: context.colorPalette.grey66,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                        ),
                      CourseText(
                        "${MySharedPreferences.user.currencySympol} ${section.discountPrice ?? section.sectionPrice}",
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
        title: Row(
          children: [
            CustomSvg(_allowShow ? MyIcons.unLock : MyIcons.lock),
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
                    onTap:_allowShow? () {
                      onTapVideo(element.vimeoId!,element.id!);
                      //context.push(VimeoPlayerScreen(vimeoId: element.vimeoId!, videoId: element.id!,isFullScreen: true));
                    } : null ,
                    child: Row(
                      children: [
                        CustomSvg( _allowShow ? MyIcons.playCirclePaid : MyIcons.playCircle),
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
                      onTap: _allowShow? () {
                        context.push(
                          FileScreen(
                            url: element.document!.document!,
                            fileName: element.document!.name!,
                          ),
                        );
                      } : null,
                      child: Row(
                        children: [
                           CustomSvg(_sectionAllow ? MyIcons.attachPaid : MyIcons.attach),
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
              onTap:  _allowShow? () {
                context.push(
                  FileScreen(
                    url: document.document!,
                    fileName: document.name!,
                  ),
                );
              } : null,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    CustomSvg(_sectionAllow ? MyIcons.attachPaid: MyIcons.attach),
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
          ...section.exams!.map((element) {
            return GestureDetector(
              onTap: element.paymentType == 0 || (section.paymentStatus == 1 && element.paymentType == 1)
                 ? () {
                       context.push(ExamScreen(payUrl:element.link!));
                  }
                 :null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    CustomSvg(
                      element.paymentType == 0 || (section.paymentStatus == 1 && element.paymentType == 1)
                      ? MyIcons.examOpen
                      :MyIcons.examClose,
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: CourseText(
                        element.name!,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          if(section.type != PaymentType.free && section.paymentStatus != PaymentStatus.paid)
          section.type == PaymentType.notFree && section.sectionPrice == 0
          ? const SizedBox.shrink()
          : GestureDetector(
            onTap: onTap,
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
