import 'package:bebrain/helper/ui_helper.dart';
import 'package:bebrain/model/new_request_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/request/widgets/file_card.dart';
import 'package:bebrain/screens/request/widgets/request_loading.dart';
import 'package:bebrain/screens/request/widgets/request_nav_bar.dart';
import 'package:bebrain/screens/request/widgets/request_text.dart';
import 'package:bebrain/screens/request/widgets/request_tile.dart';
import 'package:bebrain/screens/request/widgets/shared_container.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class RequestScreen extends StatefulWidget {
  final int requestId;
  const RequestScreen({super.key, required this.requestId});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  late MainProvider _mainProvider;
  late Future<NewRequestModel> _requestFuture;

  void _initializeFuture() async {
    _requestFuture = _mainProvider.fetchRequest(widget.requestId);
  }

  

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
    _initializeFuture();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _requestFuture,
      withBackgroundColor: true,
      onLoading: () => const RequestLoading(),
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onComplete: (context, snapshot) {
        final request = snapshot.data!;
        return Scaffold(
          bottomNavigationBar: RequestNavBar(price: request.data!.price!),
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
                              "${context.appLocalization.requestNumber} : ${request.data!.requestNumber}",
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
                              color: UiHelper.getRequestColor(context,type: request.data!.statusType!),
                              borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                            ),
                            child: RequestText(
                              request.data!.status!,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      RequestText(
                        "${context.appLocalization.dateSendingRequest} : ${request.data!.createdDate} / ${request.data!.createdTime}",
                        textColor: context.colorPalette.grey66,
                        fontSize: 10,
                      ),
                      const SizedBox(height: 10),
                      RequestTile(
                        "${context.appLocalization.country} : ${request.data!.country!}",
                      ),
                      RequestTile(
                        "${context.appLocalization.university} : ${request.data!.universityName!}",
                      ),
                      RequestTile(
                        "${context.appLocalization.college} : ${request.data!.collegeName!}",
                      ),
                      RequestTile(
                        "${context.appLocalization.specialization} : ${request.data!.majorName!}",
                      ),
                      RequestTile(
                        "${context.appLocalization.title} : ${request.data!.title}",
                      ),
                      if(request.data!.note!=null)
                      RequestTile(
                        "${context.appLocalization.notes} : ${request.data!.note}",
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
                        itemCount: request.data!.userAttachment!.length,
                        padding: const EdgeInsetsDirectional.only(start: 15, end: 10),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (contxet, index) {
                          return  FileCard(attachment:request.data!.userAttachment![index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(request.data!.reply!=null)
                      RequestText(
                        context.appLocalization.assistantResponse,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      if(request.data!.reply!=null)
                      SharedContainer(
                        child: Column(
                          children: [
                             RequestText(
                              request.data!.reply!,
                            ),
                            Align(
                              alignment: MySharedPreferences.language ==
                                      LanguageEnum.arabic
                                  ? Alignment.bottomLeft
                                  : Alignment.bottomRight,
                              child: RequestText(
                                "${request.data!.replyDate} / ${request.data!.replyTime}",
                                textColor: context.colorPalette.grey66,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if(request.data!.adminAttachment!.isNotEmpty)
                      Center(
                        child: SizedBox(
                        height: 95,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(width: 6),
                          itemCount: request.data!.adminAttachment!.length,
                          padding: const EdgeInsetsDirectional.only(start: 15, end: 10),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (contxet, index) {
                            return  FileCard(attachment:request.data!.adminAttachment![index]);
                          },
                        ),
                       ),
                      ),
                      const SizedBox(height: 15),
                      if(request.data!.videos!.isNotEmpty)
                       ListView.separated(
                         separatorBuilder: (context, index) => const SizedBox(height: 6),
                         itemCount: request.data!.videos!.length,
                         physics: const NeverScrollableScrollPhysics(),
                         padding: EdgeInsets.zero,
                         shrinkWrap: true,
                         scrollDirection: Axis.vertical,
                         itemBuilder: (contxet, index) {
                           return  SizedBox(
                            height: 190,
                             child: VimeoPlayer(
                              videoId: request.data!.videos![index].vimeoId!,
                              ),
                           );
                         },
                       ),
                      const SizedBox(height: 15),
                      RequestText(context.appLocalization.contactTheAssistant)
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
