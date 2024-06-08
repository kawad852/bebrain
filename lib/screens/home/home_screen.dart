import 'dart:developer';

import 'package:bebrain/model/college_filter_model.dart';
import 'package:bebrain/model/country_filter_model.dart' as cou;
import 'package:bebrain/model/university_filter_model.dart' as un;
import 'package:bebrain/providers/auth_provider.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/home/widgets/action_container.dart';
import 'package:bebrain/screens/home/widgets/appbar_text.dart';
import 'package:bebrain/screens/home/widgets/departments_card.dart';
import 'package:bebrain/screens/home/widgets/eduction_card.dart';
import 'package:bebrain/screens/home/widgets/filter_loading.dart';
import 'package:bebrain/screens/home/widgets/my_subscription.dart';
import 'package:bebrain/screens/registration/wizard_screen.dart';
import 'package:bebrain/utils/app_constants.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_smoth_indicator.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/distinguished_lectures.dart';
import 'package:bebrain/widgets/shimmer/shimmer_loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>with AutomaticKeepAliveClientMixin {
  late MainProvider _mainProvider;
  late AuthProvider _authProvider;
  late Future<dynamic> _future;
  int currentIndex = 0;

  Future<dynamic> _initializeFuture() async {
    switch (context.authProvider.wizardValues.wizardType) {
      case WizardType.countries:
        return _mainProvider.filterByCountry(context.authProvider.wizardValues.countryId!);
      case WizardType.universities:
        return _mainProvider.filterByUniversity(context.authProvider.wizardValues.universityId!);
      case WizardType.colleges:
      case WizardType.specialities:
        return _mainProvider.filterByCollege(context.authProvider.wizardValues.collegeId!);
    }
  }

  @override
  void initState() {
    super.initState();
    log(MySharedPreferences.accessToken);
    _mainProvider = context.mainProvider;
    _authProvider = context.authProvider;
    _authProvider.addListener(_handleChanged);
    _future = _initializeFuture();
  }

  @override
  void dispose() {
    _authProvider.removeListener(_handleChanged);
    super.dispose();
  }

  void _handleChanged() {
    setState(() {
      _future = _initializeFuture();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leadingWidth: kBarLeadingWith,
            leading: const MySubscription(),
            actions: [
              ActionContainer(
                onTap: () {
                  context.push(const WizardScreen(wizardType: WizardType.countries));
                },
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
                    separatorBuilder: (context, index) =>const SizedBox(width: 7),
                    itemCount: 10,
                    padding:const EdgeInsetsDirectional.only(top: 10, start: 13),
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
            future: _future,
            sliver: true,
            onRetry: () {
              setState(() {
                _future = _initializeFuture();
              });
            },
            onLoading: () {
              return const ShimmerLoading(child: FilterLoading());
            },
            onComplete: (context, snapshot) {
              late final dynamic filter;
              late final List<dynamic> data;
              late final List<cou.Professor> professors;
              int? collegeId;

              switch (context.authProvider.wizardValues.wizardType) {
                case WizardType.countries:
                  filter = snapshot.data! as cou.CountryFilterModel;
                  data = filter.data!.universities! as List<cou.University>;
                  professors = filter.data!.professors!;
                case WizardType.universities:
                  filter = snapshot.data! as un.UniversityFilterModel;
                  data = filter.data!.university!.colleges! as List<un.College>;
                  professors = filter.data!.professors!;
                case WizardType.colleges:
                case WizardType.specialities:
                  filter = snapshot.data! as CollegeFilterModel;
                  data = filter.data!.majors! as List<Major>;
                  collegeId = filter.data!.college!.id!;
                  professors = filter.data!.professors!;
              }
              return SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                sliver: SliverToBoxAdapter(
                  child: ShrinkWrappingViewport(
                    offset: ViewportOffset.zero(),
                    slivers: [
                      SliverList.separated(
                        separatorBuilder: (context, index) =>const SizedBox(height: 8),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return DepartmentsCard(
                            data: data[index],
                            collegeId: collegeId,
                            onTapSubData: () {
                              setState(() {
                                _future = _initializeFuture();
                              });
                            },
                          );
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

  @override
  bool get wantKeepAlive => true;
}
