import 'dart:developer';

import 'package:bebrain/model/new_request_model.dart';
import 'package:bebrain/screens/request/widgets/request_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FileCard extends StatelessWidget {
  final UserAttachment attachment;
  const FileCard({super.key, required this.attachment});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        log(attachment.attachment!.split('/').last);
        // String? file=await FlutterDownloader.enqueue(
        //   url:attachment.attachment!,
        //   savedDir: '/storage/emulated/0/Download',
        //   showNotification: true,
        //   openFileFromNotification: true,
        // );
        // FlutterDownloader.registerCallback(file);
      },
      child: Container(
        width: 82,
        height: 93,
        decoration: BoxDecoration(
          color: context.colorPalette.greyEEE,
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        ),
        child: Column(
          children: [
            Container(
              width: 30,
              height: 30,
              margin: const EdgeInsetsDirectional.only(top: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colorPalette.blueC2E,
                shape: BoxShape.circle,
              ),
              child: const CustomSvg(MyIcons.axes),
            ),
             Flexible(
              child: RequestText(
                attachment.attachment!.split('/').last,
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 21,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colorPalette.blueC2E,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(MyTheme.radiusSecondary),
                  bottomRight: Radius.circular(MyTheme.radiusSecondary),
                ),
              ),
              child: RequestText(
                context.appLocalization.download,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
