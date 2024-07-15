import 'package:bebrain/model/new_request_model.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/file_card.dart';
import 'package:bebrain/widgets/request_text.dart';
import 'package:bebrain/widgets/request_tile.dart';
import 'package:flutter/material.dart';

class BookingRequestScreen extends StatefulWidget {
  const BookingRequestScreen({super.key});

  @override
  State<BookingRequestScreen> createState() => _BookingRequestScreenState();
}

class _BookingRequestScreenState extends State<BookingRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          "${context.appLocalization.requestNumber} : 5454545454",
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
                          color: context.colorPalette.blueA3C,
                          // UiHelper.getRequestColor(context,type: request.data!.statusType!),
                          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                        ),
                        child: const RequestText(
                          "تم التأكيد",
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  RequestText(
                    "${context.appLocalization.dateSendingRequest} : 10/02/2024 / 10:20:20",
                    textColor: context.colorPalette.grey66,
                    fontSize: 10,
                  ),
                  const SizedBox(height: 10),
                  RequestTile(
                    "${context.appLocalization.subject} : subject",
                  ),
                  RequestTile(
                    "${context.appLocalization.title} : title",
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RequestTile(
                          "${context.appLocalization.date} : date",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: RequestTile(
                          "${context.appLocalization.theHour} : hours",
                        ),
                      ),
                    ],
                  ),
                  //if(request.data!.note!=null)
                  RequestTile(
                    "${context.appLocalization.notes} : notes",
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
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
                SizedBox(
                  height: 95,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(width: 6),
                    itemCount: 5,
                    padding: const EdgeInsetsDirectional.only(start: 15, end: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (contxet, index) {
                      return FileCard(
                        attachment: UserAttachment(attachment: "ddd", filename: "ddd", id: 2),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
  }
}
