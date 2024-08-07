import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:bebrain/helper/ui_helper.dart';
import 'package:bebrain/model/college_filter_model.dart';
import 'package:bebrain/model/continue_learning_model.dart';
import 'package:bebrain/model/country_filter_model.dart' as cou;
import 'package:bebrain/model/slider_model.dart';
import 'package:bebrain/model/university_filter_model.dart' as un;
import 'package:bebrain/providers/auth_provider.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/home/widgets/action_container.dart';
import 'package:bebrain/screens/home/widgets/appbar_text.dart';
import 'package:bebrain/screens/home/widgets/departments_card.dart';
import 'package:bebrain/screens/home/widgets/eduction_card.dart';
import 'package:bebrain/screens/home/widgets/filter_loading.dart';
import 'package:bebrain/screens/home/widgets/my_slider.dart';
import 'package:bebrain/screens/home/widgets/my_subscription.dart';
import 'package:bebrain/screens/home/widgets/slider_loading.dart';
import 'package:bebrain/screens/registration/wizard_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/distinguished_lectures.dart';
import 'package:bebrain/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  late MainProvider _mainProvider;
  late AuthProvider _authProvider;
  late Future<dynamic> _future;
  late Future<ContinueLearningModel> _learningFuture;
  late Future<SliderModel> _sliderFuture;
  int currentIndex = 0;

  Future<dynamic> _initializeFuture() async {
    switch (_authProvider.wizardValues.wizardType) {
      case WizardType.countries:
        return _mainProvider.filterByCountry(_authProvider.wizardValues.countryId!);
      case WizardType.universities:
        return _mainProvider.filterByUniversity(_authProvider.wizardValues.universityId!);
      case WizardType.colleges:
      case WizardType.specialities:
        return _mainProvider.filterByCollege(_authProvider.wizardValues.collegeId!);
    }
  }

  void _initializeSliderFuture() async {
    _sliderFuture =_mainProvider.fetchMySlider(_authProvider.wizardValues.countryId!);
  }


  void _initializeLearningFuture() async {
    _learningFuture = _mainProvider.fetchMyLearning();
  }

  @override
  void initState() {
    super.initState();
    log(MySharedPreferences.accessToken);
    _mainProvider = context.mainProvider;
    _authProvider = context.authProvider;
    UiHelper().addListener(_handleChanged);
    _future = _initializeFuture();
    _initializeSliderFuture();
    _initializeLearningFuture();
  }

  @override
  void dispose() {
    UiHelper().removeListener(_handleChanged);
    super.dispose();
  }

  void _handleChanged() {
    setState(() {
      _initializeLearningFuture();
      _initializeSliderFuture();
      _future = _initializeFuture();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _future = _initializeFuture();
            _initializeLearningFuture();
            _initializeSliderFuture();
          });
        },
        child: CustomScrollView(
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
                  onTap: () {
                    UiHelper.whatsAppContact(context);
                  },
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
                 CustomFutureBuilder(
                  future: _sliderFuture,
                  onRetry: (){
                    setState(() {
                      _initializeSliderFuture();
                    });
                  },
                  onLoading: () => const SliderLoading(),
                  onComplete: (context,snapshot){
                    final slider =snapshot.data!;
                    return slider.data!.isEmpty
                    ? const SizedBox.shrink()
                    : MySlider(slider: slider.data!);
                  },
                 ),
                  Selector<AuthProvider, bool>(
                      selector: (context, provider) => provider.isAuthenticated,
                      builder: (context, isAuthenticated, child) {
                        return isAuthenticated
                            ? CustomFutureBuilder(
                                future: _learningFuture,
                                onRetry: () {
                                  setState(() {
                                    _initializeLearningFuture();
                                  });
                                },
                                onError: (snapshot) => const SizedBox.shrink(),
                                onLoading: () => const SizedBox.shrink(),
                                onComplete: (context, snapshot) {
                                  final continueLearningData = snapshot.data!;
                                  return  continueLearningData.data!.isEmpty
                                  ? const SizedBox.shrink()
                                  : ZoomIn(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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
                                            itemCount: continueLearningData.data!.length,
                                            padding: const EdgeInsetsDirectional.only(top: 10, start: 13),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return EductionCard(learningData:continueLearningData.data![index]);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : const SizedBox.shrink();
                      }),
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
                List<dynamic> filterData=[];
                late final List<cou.Professor> professors;
                int? collegeId;

                switch (_authProvider.wizardValues.wizardType) {
                  case WizardType.countries:
                    filter = snapshot.data! as cou.CountryFilterModel;
                    data = filter.data!.universities! as List<cou.University>;
                    professors = filter.data!.professors!;
                  case WizardType.universities:
                    filter = snapshot.data! as un.UniversityFilterModel;
                    data =filter.data!.university!.colleges! as List<un.College>;
                    professors = filter.data!.professors!;
                  case WizardType.colleges:
                  case WizardType.specialities:
                    filter = snapshot.data! as CollegeFilterModel;
                    data = filter.data!.majors! as List<Major>;
                    collegeId = filter.data!.college!.id!;
                    professors = filter.data!.professors!;
                }
                data.map((element){
                  if(element.courses.isNotEmpty){
                    filterData.add(element);
                  }
                }).toSet();
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  sliver: SliverToBoxAdapter(
                    child: ShrinkWrappingViewport(
                      offset: ViewportOffset.zero(),
                      slivers: [
                        SliverList.separated(
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                          itemCount: filterData.length,
                          itemBuilder: (context, index) {
                            return DepartmentsCard(
                              data: filterData[index],
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
