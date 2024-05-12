import 'package:animate_do/animate_do.dart';
import 'package:bebrain/screens/intro/widgets/intro_bubble.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_images.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

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
      body: Stack(
        children: [
          Positioned(
            top: 110,
            left: 25,
            child: ShakeY(
              from: 20,
              duration: const Duration(seconds: 5),
              infinite: true,
              child: const CustomSvg(MyIcons.introBubble0),
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
            child: Image.asset(MyImages.intro0),
          ),
        ],
      ),
    );
  }
}
