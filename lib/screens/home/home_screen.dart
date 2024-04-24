import 'package:bebrain/screens/home/widgets/action_container.dart';
import 'package:bebrain/screens/home/widgets/appbar_text.dart';
import 'package:bebrain/screens/home/widgets/departments_card.dart';
import 'package:bebrain/widgets/distinguished_lectures.dart';
import 'package:bebrain/screens/home/widgets/eduction_card.dart';
import 'package:bebrain/screens/home/widgets/my_subscription.dart';
import 'package:bebrain/utils/app_constants.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_smoth_indicator.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leadingWidth: kBarLeadingWith,
            leading: const MySubscription(),
            actions: [
              ActionContainer(
                onTap: () {},
                hasBorder: true,
                child: const CustomSvg(MyIcons.filter),
              ),
              const SizedBox(width: 5),
              ActionContainer(
                onTap: () {},
                color: context.colorPalette.blueC2E,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomSvg(MyIcons.help),
                    AppBarText(
                      context.appLocalization.helper,
                      fontSize: 10,
                    )
                  ],
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider.builder(
                  itemCount: 5,
                  options: CarouselOptions(
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    height: 130.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return const CustomNetworkImage(
                      kFakeImage,
                      width: double.infinity,
                      height: 130,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      radius: MyTheme.radiusSecondary,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: CustomSmoothIndicator(
                      count: 5,
                      index: currentIndex,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      const CustomSvg(MyIcons.eductionCircle),
                      const SizedBox(width: 7),
                      Text(
                        context.appLocalization.pursueEducation,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 110,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(width: 7),
                    itemCount: 10,
                    padding: const EdgeInsetsDirectional.only(top: 10, start: 13),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, indxe) {
                      return const EductionCard();
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: 3,
              itemBuilder: (context, index) {
                return const DepartmentsCard();
              },
            ),
          ),
           SliverToBoxAdapter(
            child: DistinguishedLectures(title: context.appLocalization.distinguishedLecturers),
          ),
        ],
      ),
    );
  }
}
