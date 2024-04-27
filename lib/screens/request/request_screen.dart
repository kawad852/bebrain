import 'package:bebrain/screens/request/widgets/file_card.dart';
import 'package:bebrain/screens/request/widgets/request_nav_bar.dart';
import 'package:bebrain/screens/request/widgets/request_text.dart';
import 'package:bebrain/screens/request/widgets/request_tile.dart';
import 'package:bebrain/screens/request/widgets/shared_container.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/widgets/custom_loading_indicator.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(
        'https://cllllb.com/assets/img/club/2023/11/170003674156065724_861437017527465_7048239623259199580_n.mp4'))
      ..initialize().then(
        (value) {
          setState(
            () {
              _chewieController = ChewieController(
                videoPlayerController: _videoController,
                autoInitialize: true,
                autoPlay: true,
                showControls: true,
                allowMuting: true,
                aspectRatio: _videoController.value.aspectRatio,
                allowPlaybackSpeedChanging: true,
                customControls: const MaterialControls(),
              );
            },
          );
        },
      );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const RequestNavBar(),
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
                          "${context.appLocalization.requestNumber} : 74356235",
                          overflow: TextOverflow.ellipsis,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 68,
                        height: 23,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.colorPalette.blueC2E,
                          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                        ),
                        child: const RequestText(
                          "مكتمل",
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  RequestText(
                    "${context.appLocalization.dateSendingRequest} : PM 02:51:23",
                    textColor: context.colorPalette.grey66,
                    fontSize: 10,
                  ),
                  const SizedBox(height: 10),
                  RequestTile(
                    "${context.appLocalization.country} : الأردن",
                  ),
                  RequestTile(
                    "${context.appLocalization.university} : الجامعة الأردنية",
                  ),
                  RequestTile(
                    "${context.appLocalization.college} : كلية الملك عبدالله لتكنلوجيا المعلومات",
                  ),
                  RequestTile(
                    "${context.appLocalization.specialization} : علم الحاسوب",
                  ),
                  RequestTile(
                    "${context.appLocalization.title} : حل واجب كالكولاس",
                  ),
                  RequestTile(
                    "${context.appLocalization.notes} :  تفاصيل الواجب المراد حله والذي تم طلبه من قبل المستخدم",
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
                  height: 93,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(width: 6),
                    itemCount: 10,
                    padding: const EdgeInsetsDirectional.only(start: 15, end: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (contxet, index) {
                      return const FileCard();
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
                  RequestText(
                    context.appLocalization.assistantResponse,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  SharedContainer(
                    child: Column(
                      children: [
                        const RequestText(
                            "تم الحل يمكنك تحميل المرفق وشكراً لإستخدامك المساعد",
                            ),
                        Align(
                          alignment: MySharedPreferences.language==LanguageEnum.arabic?
                             Alignment.bottomLeft:Alignment.bottomRight,
                          child: RequestText(
                            "PM 02:51:23",
                            textColor: context.colorPalette.grey66,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const FileCard(),
                  const SizedBox(height: 15),
                  _videoController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                            child: Chewie(
                              controller: _chewieController,
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 200,
                          child: CustomLoadingIndicator(withBackgroundColor: true),
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
  }
}
