import 'package:bebrain/helper/ui_helper.dart';
import 'package:bebrain/model/new_request_model.dart';
import 'package:bebrain/screens/request/request_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class PreviousRequest extends StatelessWidget {
  final RequestData request;
  const PreviousRequest({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push( RequestScreen(requestId: request.id!));
      },
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: context.colorPalette.greyEEE,
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorPalette.greyD9D,
              ),
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorPalette.blue8DD,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    request.title!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.colorPalette.black33,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${context.appLocalization.requestNumber} : ${request.requestNumber}",
                    style: TextStyle(
                      color: context.colorPalette.grey66,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 68,
              height: 23,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:UiHelper.getRequestColor(context, type: request.statusType!),
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
              ),
              child:  Text(
                request.status!,
                style:const TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
