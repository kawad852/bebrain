import 'package:bebrain/helper/ui_helper.dart';
import 'package:bebrain/model/interview_model.dart';
import 'package:bebrain/screens/booking/booking_request_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class PreviousBooking extends StatelessWidget {
  final InterviewData interviewData;
  const PreviousBooking({super.key, required this.interviewData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(BookingRequestScreen(interViewId: interviewData.id!));
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
                    "${context.appLocalization.bookWith}${interviewData.professorName}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.colorPalette.black33,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${context.appLocalization.requestNumber} : ${interviewData.interviewNumber}",
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
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: UiHelper.getRequestColor(context, type: interviewData.statusType!),
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
              ),
              child: Text(
                interviewData.status!,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
