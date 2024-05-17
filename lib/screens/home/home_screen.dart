import 'dart:developer';

import 'package:bebrain/model/country_filter_model.dart';
import 'package:bebrain/providers/home_provider.dart';
import 'package:bebrain/screens/home/widgets/action_container.dart';
import 'package:bebrain/screens/home/widgets/appbar_text.dart';
import 'package:bebrain/screens/home/widgets/departments_card.dart';
import 'package:bebrain/screens/home/widgets/eduction_card.dart';
import 'package:bebrain/screens/home/widgets/my_subscription.dart';
import 'package:bebrain/utils/app_constants.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_smoth_indicator.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/distinguished_lectures.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider _homeProvider;
  late Future<CountryFilterModel> _countryFilterFuture;

  void _initializeFuture() async {
    _countryFilterFuture = _homeProvider.filterByCountry(1);
  }

  @override
  void initState() {
    super.initState();
    log(MySharedPreferences.accessToken);
    _homeProvider = context.homeProvider;
    _initializeFuture();
  }

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
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 7),
                    itemCount: 10,
                    padding:
                        const EdgeInsetsDirectional.only(top: 10, start: 13),
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
          CustomFutureBuilder(
            future: _countryFilterFuture,
            onRetry: () {
              setState(() {
                _initializeFuture();
              });
            },
            sliver: true,
            onComplete: (context, snapshot) {
              final countryFilter=snapshot.data!;
              final universities=countryFilter.data!.universities!;
              final professors=countryFilter.data!.professors!;
              return SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                sliver: SliverToBoxAdapter(
                  child: ShrinkWrappingViewport(
                    offset: ViewportOffset.zero(),
                    slivers: [
                      SliverList.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 5),
                        itemCount: universities.length,
                        itemBuilder: (context, index) {
                          return  DepartmentsCard(university:universities[index]);
                        },
                      ),
                      SliverToBoxAdapter(
                        child: DistinguishedLectures(
                          title: context.appLocalization.distinguishedLecturers,
                          professors: professors,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
