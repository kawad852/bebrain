import 'dart:io';

import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/model/new_request_model.dart';
import 'package:bebrain/widgets/request_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileCard extends StatefulWidget {
  final UserAttachment attachment;
  const FileCard({
    super.key,
    required this.attachment,
  });

  @override
  State<FileCard> createState() => _FileCardState();
}

class _FileCardState extends State<FileCard> {
  bool _isLoading = false;
  Future<void> _downloadFile() async {
    final permissionStatus = await Permission.storage.request();

    if (permissionStatus.isGranted) {
      try {
        var httpClient = HttpClient();
        var request =await httpClient.getUrl(Uri.parse(widget.attachment.attachment!));
        var response = await request.close();
        var bytes = await consolidateHttpClientResponseBytes(response);
        String dir = Platform.isIOS?(await getApplicationDocumentsDirectory()).path:(await getExternalStorageDirectory())!.path;
        File file = File('$dir/${widget.attachment.filename!}');
        await file.writeAsBytes(bytes);
        OpenFilex.open('$dir/${widget.attachment.filename}');
      } catch (ex) {
        if (mounted) {
          context.showSnackBar(context.appLocalization.generalError);
        }
      }
    } else {
      debugPrint('Permission denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _isLoading = true;
        });
        await _downloadFile().then((value) {
          setState(() {
            _isLoading = false;
          });
        });
      },
      child: Container(
        width: 82,
        height: 95,
        decoration: BoxDecoration(
          color: context.colorPalette.greyEEE,
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        ),
        child: Column(
          children: [
            _isLoading
                ? const SizedBox(
                    width: 40,
                    height: 40,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: CircularProgressIndicator(strokeWidth: 1.8),
                    ),
                  )
                : Container(
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
            RequestText(
              widget.attachment.filename!,
              maxLines: 2,
              fontSize: 12,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
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
