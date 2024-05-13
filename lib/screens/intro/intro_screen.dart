import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:bebrain/screens/intro/widgets/intro_bubble.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_images.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.colorPalette.blueC2E,
        body: PageView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Positioned(
                  top: 110,
                  left: 25,
                  child: ShakeX(
                    from: 20,
                    duration: const Duration(seconds: 5),
                    infinite: true,
                    child: ShakeY(
                      from: 20,
                      duration: const Duration(seconds: 5),
                      infinite: true,
                      child: const CustomSvg(MyIcons.introBubble0),
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  right: 50,
                  child: ShakeX(
                    from: 20,
                    duration: const Duration(seconds: 5),
                    infinite: true,
                    child: const IntroBubble(icon: MyIcons.axes),
                  ),
                ),
                Positioned(
                  top: 220,
                  right: 35,
                  child: ShakeY(
                    from: 20,
                    duration: const Duration(seconds: 5),
                    infinite: true,
                    child: const IntroBubble(icon: MyIcons.videoPlay),
                  ),
                ),
                const Positioned(
                  top: 25,
                  left: 90,
                  child: CustomSvg(MyIcons.arrow0),
                ),
                const Positioned(
                  top: 100,
                  left: 75,
                  child: CustomSvg(MyIcons.arrow1),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(MyImages.intro0),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Transform.rotate(
                          angle: pi / 13,
                          child: Container(
                            width: 235,
                            height: 80,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: context.colorPalette.greyF6F,
                              borderRadius: BorderRadius.circular(
                                  MyTheme.radiusSecondary),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: context.colorPalette.greyE0E,
                                    borderRadius: BorderRadius.circular(
                                        MyTheme.radiusSecondary),
                                  ),
                                  child: const CustomSvg(MyIcons.fakeProfile),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "A distinctive and very simple way of explaining",
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      RatingBar.builder(
                                        initialRating: 5,
                                        direction: Axis.horizontal,
                                        ignoreGestures: true,
                                        itemSize: 25,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 3),
                                        itemBuilder: (context, _) =>
                                            const CustomSvg(MyIcons.star),
                                        onRatingUpdate: (rating) {},
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
