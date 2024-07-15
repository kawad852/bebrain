import 'package:bebrain/helper/ui_helper.dart';
import 'package:bebrain/model/single_interview_model.dart';
import 'package:bebrain/providers/main_provider.dart';
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

class BookingRequestScreen extends StatefulWidget {
  final int interViewId;
  const BookingRequestScreen({super.key, required this.interViewId});

  @override
  State<BookingRequestScreen> createState() => _BookingRequestScreenState();
}

class _BookingRequestScreenState extends State<BookingRequestScreen> {
  late MainProvider _mainProvider;
  late Future<SingleInterviewModel> _interviewFuture;

  void _initializeFuture() {
    _interviewFuture = _mainProvider.fetchInterViewById(widget.interViewId);
  }

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
    _initializeFuture();
  }

  String _formatTime(String time){
   return DateFormat("hh:mm a").format(DateFormat("hh:mm:ss").parse(time).toUTC(context));
  }

  String _finishMeetingTime(String time, int meetingPeriod){
    return DateFormat("hh:mm").format(DateFormat("hh:mm:ss").parse(time).add(Duration(hours: meetingPeriod)).toUTC(context));
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
            onTap: (){
              context.paymentProvider.pay(
                context,
                subscribtionId: interView.id!,
                amount: interView.price!,
                orderType: OrderType.interview,
                afterPay: (){
                  setState(() {
                    _initializeFuture();
                  });
                },
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
                              "${context.appLocalization.theHour} : ${DateFormat("hh:mm").format(DateFormat("hh:mm:ss").parse(interView.meetingTime!).toUTC(context))} - ${_finishMeetingTime(interView.meetingTime!, interView.meetingPeriod!)}",
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
