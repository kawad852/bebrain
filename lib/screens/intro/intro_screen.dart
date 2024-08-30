import 'package:animate_do/animate_do.dart';
import 'package:bebrain/screens/intro/widgets/intro_bubble.dart';
import 'package:bebrain/screens/intro/widgets/intro_card.dart';
import 'package:bebrain/screens/registration/registration_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_images.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/widgets/custom_smoth_indicator.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  List<String> introBubbleIcon = [
    MyIcons.introBubble0,
    MyIcons.introBubble1,
    MyIcons.introBubble2
  ];
  List<String> topIcon = [
    MyIcons.axes,
    MyIcons.messageEdit,
    MyIcons.messageEdit
  ];
  List<String> bottomIcon = [MyIcons.videoPlay, MyIcons.sms, MyIcons.gallery];
  List<String> mainImage = [MyImages.intro0, MyImages.intro1, MyImages.intro2];
  late List<String> titleIntro;
  late List<String> discriptionIntro;
  late List<String> introCard;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    titleIntro = [
      context.appLocalization.introTitle0,
      context.appLocalization.introTitle1,
      context.appLocalization.introTitle2,
    ];
    discriptionIntro = [
      context.appLocalization.introDisc0,
      context.appLocalization.introDisc1,
      context.appLocalization.introDisc2,
    ];
    introCard = [
      context.appLocalization.distinctiveVerySimple,
      context.appLocalization.solvedPleaseDownload,
      context.appLocalization.videoHasBeenRecorded,
    ];
    return Scaffold(
      backgroundColor: context.colorPalette.blueC2E,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomSmoothIndicator(
              count: 3,
              index: _currentIndex,
            ),
            InkWell(
              onTap: () {
                if(_pageController.page == 2){
                  MySharedPreferences.isPassedIntro = true;
                  context.pushAndRemoveUntil(const RegistrationScreen());
                }
                else{
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInExpo,
                );
                }
              },
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.colorPalette.blueC2E,
                  borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                ),
                child: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: 3,
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
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
                    child: CustomSvg(introBubbleIcon[index]),
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
                  child: IntroBubble(icon: topIcon[index]),
                ),
              ),
              Positioned(
                top: 220,
                right: 35,
                child: ShakeY(
                  from: 20,
                  duration: const Duration(seconds: 5),
                  infinite: true,
                  child: IntroBubble(icon: bottomIcon[index]),
                ),
              ),
               Positioned(
                top: 25,
                left: context.mediaQuery.width *0.26,
                child: const CustomSvg(MyIcons.arrow0),
              ),
               Positioned(
                top: 100,
                left: context.mediaQuery.width *0.26,
                child: const CustomSvg(MyIcons.arrow1),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(mainImage[index]),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntroCard(title: introCard[index],isRating: index==0),
                      const SizedBox(height: 100),
                      Text(
                        titleIntro[index],
                        style: TextStyle(
                          color: context.colorPalette.blueC2E,
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 120),
                        child: Text(
                          discriptionIntro[index],
                          style: TextStyle(
                            color: context.colorPalette.white,
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
      ),
    );
  }
}
