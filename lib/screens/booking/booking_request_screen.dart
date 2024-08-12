import 'dart:developer';

import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/helper/purchases_service.dart';
import 'package:bebrain/helper/ui_helper.dart';
import 'package:bebrain/model/single_interview_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/booking/widgets/booking_request_loading.dart';
import 'package:bebrain/screens/request/widgets/request_nav_bar.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/file_card.dart';
import 'package:bebrain/widgets/request_text.dart';
import 'package:bebrain/widgets/request_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingRequestScreen extends StatefulWidget {
  final int interViewId;
  const BookingRequestScreen({super.key, required this.interViewId});

  @override
  State<BookingRequestScreen> createState() => _BookingRequestScreenState();
}

class _BookingRequestScreenState extends State<BookingRequestScreen> {
  late MainProvider _mainProvider;
  late Future<SingleInterviewModel> _interviewFuture;
  String? _orderNumber;

  void _initializeFuture() async{
    _interviewFuture = _mainProvider.fetchInterViewById(widget.interViewId);
    final _interview = await _interviewFuture;
    _orderNumber = _interview.data!.myOrder?.orderNumber;
    log(_orderNumber.toString());
  }

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
    _initializeFuture();
    PurchasesService.initialize(
      onPurchase: () {
        UiHelper.confirmPayment(
          context, 
          orderNumber: _orderNumber!,
          afterPay: (){
            setState(() {
              _initializeFuture();
            });
          }
        );
      },
    );
  }
  @override
  void dispose(){
    PurchasesService.cancel();
    super.dispose();
  }

  String _formatTime(String time){
   return DateFormat("hh:mm a").format(DateFormat("hh:mm:ss").parse(time));
  }

  String _finishMeetingTime(String time, int meetingPeriod){
    return DateFormat("hh:mm").format(DateFormat("hh:mm:ss").parse(time).add(Duration(hours: meetingPeriod)));
  }

  void _openZoom(BuildContext context,String joinUrl) async {
    try {
      final uri = Uri.parse(joinUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri);
      }
    } catch (e) {
      log("ErrorLauncher:: $e");
      if (context.mounted) {
        context.showSnackBar(context.appLocalization.generalError);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _interviewFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      withBackgroundColor: true,
      onLoading: () => const BookingRequestLoading(),
      onComplete: (context, snapshot) {
        final data = snapshot.data!;
        final interView = data.data!;
        return Scaffold(
          bottomNavigationBar:
          interView.statusType == RequestType.pending || interView.statusType == RequestType.rejected || interView.statusType == RequestType.done
          ? null
          : RequestNavBar(
            price: interView.price!,
            statusType: interView.statusType!,
            paymentDueDate: interView.paymentDueDate,
            onTap: () {
              interView.statusType == RequestType.interviewAdded
              ? _openZoom(context, interView.joinUrl!)
              : UiHelper.payment(
                context,
                title: interView.topic!,
                productId: interView.productId,
                subscribtionId: interView.id!,
                amount: interView.price!,
                orderType: OrderType.interview,
                afterPay: (){
                  setState(() {
                    _initializeFuture();
                  });
                }
              );
            },
            ),
          body: CustomScrollView(
            slivers: [
              const SliverAppBar(pinned: true),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: RequestText(
                              "${context.appLocalization.requestNumber} : ${interView.interviewNumber}",
                              overflow: TextOverflow.ellipsis,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            //width: 68,
                            height: 23,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:  UiHelper.getRequestColor(context,type: interView.statusType!),
                              borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                            ),
                            child: RequestText(
                              interView.status!,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      RequestText(
                        "${context.appLocalization.dateSendingRequest} : ${DateFormat("dd-MM-yyyy").format(interView.createdDate!)} / ${_formatTime(interView.createdTime!)}",
                        textColor: context.colorPalette.grey66,
                        fontSize: 10,
                      ),
                      const SizedBox(height: 10),
                      RequestTile(
                        "${context.appLocalization.subject} : ${interView.subjectName}",
                      ),
                      RequestTile(
                        "${context.appLocalization.title} : ${interView.topic}",
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RequestTile(
                              "${context.appLocalization.date} : ${DateFormat("dd-MM-yyyy").format(interView.meetingDate!)}",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: RequestTile(
                              "${context.appLocalization.theHour} : ${DateFormat("hh:mm").format(DateFormat("hh:mm:ss").parse(interView.meetingTime!))} - ${_finishMeetingTime(interView.meetingTime!, interView.meetingPeriod!)}",
                            ),
                          ),
                        ],
                      ),
                     if(interView.note!=null)
                      RequestTile(
                        "${context.appLocalization.notes} : ${interView.note}",
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(interView.userAttachment!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Row(
                        children: [
                          const CustomSvg(MyIcons.attach),
                          const SizedBox(width: 10),
                          RequestText(context.appLocalization.attachedFiles),
                        ],
                      ),
                    ),
                    if(interView.userAttachment!.isNotEmpty)
                    SizedBox(
                      height: 95,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(width: 6),
                        itemCount: interView.userAttachment!.length,
                        padding: const EdgeInsetsDirectional.only(start: 15, end: 10),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (contxet, index) {
                          return FileCard(
                            attachment: interView.userAttachment![index],
                          );
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: context.colorPalette.greyEEE,
                        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                      ),
                      child: RequestText(
                        context.appLocalization.professorWillCheckAppointment,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
