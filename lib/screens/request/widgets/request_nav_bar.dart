import 'package:bebrain/screens/request/widgets/request_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class RequestNavBar extends StatefulWidget {
  final double price;
  final DateTime? paymentDueDate;
  final String statusType;
  final void Function() onTap;
  const RequestNavBar({
    super.key,
    required this.price,
    this.paymentDueDate,
    required this.onTap,
    required this.statusType,
  });

  @override
  State<RequestNavBar> createState() => _RequestNavBarState();
}

class _RequestNavBarState extends State<RequestNavBar> {
  Duration difference = const Duration(days: 0, hours: 0, minutes: 0, seconds: 0);

  @override
  void initState() {
    super.initState();
    if(widget.paymentDueDate != null){
    difference = widget.paymentDueDate!.toUTC(context).difference(DateTime.now());
    }
  }


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
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RequestText(
              "\$${widget.price}",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RequestText(
                    widget.statusType == RequestType.inProgress
                        ? context.appLocalization.feesPaid
                        : widget.statusType == RequestType.canceled
                            ? context.appLocalization.feesNotPaid
                            : context.appLocalization.feesRequest,
                    textAlign: TextAlign.center,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  if (widget.statusType == RequestType.pendingPayment)
                    TweenAnimationBuilder<Duration>(
                      duration: difference,
                      tween: Tween(begin: difference, end: Duration.zero),
                      builder: (BuildContext context, Duration value, Widget? child) {
                        final hours = value.inHours;
                        final minutes = value.inMinutes.remainder(60);
                        final seconds = value.inSeconds.remainder(60);
                        return RequestText(
                          "${context.appLocalization.timeRemainingPayment} $hours:$minutes:$seconds",
                          textColor: context.colorPalette.grey66,
                          fontSize: 12,
                        );
                      },
                    ),
                ],
              ),
            ),
            if (widget.statusType == RequestType.pendingPayment)
              GestureDetector(
                onTap: widget.onTap,
                child: Container(
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
              ),
          ],
        ),
      ),
    );
  }
}
