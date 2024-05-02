import 'package:bebrain/screens/course/widgets/course_nav_bar.dart';
import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/screens/course/widgets/leading_back.dart';
import 'package:bebrain/screens/course/widgets/part_card.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_loading_indicator.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CoursePartScreen extends StatefulWidget {
  const CoursePartScreen({super.key});

  @override
  State<CoursePartScreen> createState() => _CoursePartScreenState();
}

class _CoursePartScreenState extends State<CoursePartScreen> {
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
      bottomNavigationBar: const CourseNavBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            scrolledUnderElevation: 0,
            collapsedHeight: kBarCollapsedHeight,
            leading: const LeadingBack(),
            flexibleSpace: _videoController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  )
                : const CustomLoadingIndicator(withBackgroundColor: true),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Expanded(
                        child: CourseText(
                          "الجزء الثاني",
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          CourseText(
                            "\$30",
                            textColor: context.colorPalette.grey66,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.bold,
                          ),
                          const CourseText(
                            "\$9",
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                  CourseText(
                    "محاسبة الشركات",
                    textColor: context.colorPalette.grey66,
                    fontWeight: FontWeight.bold,
                  ),
                  StretchedButton(
                    onPressed: () {},
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            CourseText(
                              "\$30",
                              textColor: context.colorPalette.grey66,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.bold,
                            ),
                            CourseText(
                              "\$9",
                              textColor: context.colorPalette.black33,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        CourseText(
                          "الإشتراك في الجزء الثاني فقط",
                          fontWeight: FontWeight.bold,
                          textColor: context.colorPalette.black33,
                        ),
                        Container(
                          width: 46,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: context.colorPalette.blue8DD,
                            borderRadius:
                                BorderRadius.circular(MyTheme.radiusSecondary),
                          ),
                          child: CourseText(
                            context.appLocalization.buying,
                            textColor: context.colorPalette.black33,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: 4,
              itemBuilder: (context, index) {
                return const PartCard();
              },
            ),
          )
        ],
      ),
    );
  }
}
