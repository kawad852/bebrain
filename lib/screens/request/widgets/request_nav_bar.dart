import 'package:bebrain/screens/request/widgets/request_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class RequestNavBar extends StatelessWidget {
  const RequestNavBar({super.key});

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const RequestText(
              "\$25",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RequestText(
                  context.appLocalization.feesRequest,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                RequestText(
                  "${context.appLocalization.timeRemainingPayment} 23:59:02",
                  textColor: context.colorPalette.grey66,
                  fontSize: 12,
                ),
              ],
            ),
            Container(
              width: 46,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colorPalette.blue8DD,
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
              ),
              child: RequestText(
                context.appLocalization.pay,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
