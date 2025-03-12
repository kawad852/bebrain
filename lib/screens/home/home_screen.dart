import 'dart:async';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:bebrain/helper/ui_helper.dart';
import 'package:bebrain/model/college_filter_model.dart';
import 'package:bebrain/model/continue_learning_model.dart';
import 'package:bebrain/model/country_filter_model.dart' as cou;
import 'package:bebrain/model/major_filter_model.dart';
import 'package:bebrain/model/slider_model.dart';
import 'package:bebrain/model/university_filter_model.dart' as un;
import 'package:bebrain/providers/auth_provider.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/department/widgets/course_card.dart';
import 'package:bebrain/screens/home/widgets/action_container.dart';
import 'package:bebrain/screens/home/widgets/appbar_text.dart';
import 'package:bebrain/screens/home/widgets/departments_card.dart';
import 'package:bebrain/screens/home/widgets/eduction_card.dart';
import 'package:bebrain/screens/home/widgets/filter_loading.dart';
import 'package:bebrain/screens/home/widgets/major_filter_loading.dart';
import 'package:bebrain/screens/home/widgets/my_slider.dart';
import 'package:bebrain/screens/home/widgets/my_subscription.dart';
import 'package:bebrain/screens/home/widgets/online_professors.dart';
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
import 'package:bebrain/widgets/editors/base_editor.dart';
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
  late List<cou.Course> majorCourse;
  Timer? _debounce;
  String _query = '';

  Future<dynamic> _initializeFuture() async {
    switch (_authProvider.wizardValues.wizardType) {
      case WizardType.countries:
        return _mainProvider.filterByCountry(_authProvider.wizardValues.countryId!);
      case WizardType.universities:
        return _mainProvider.filterByUniversity(_authProvider.wizardValues.universityId!);
      case WizardType.colleges:
        return _mainProvider.filterByCollege(_authProvider.wizardValues.collegeId!);
      case WizardType.specialities:
        return _mainProvider.filterByMajor(collegeId: _authProvider.wizardValues.collegeId!, majorId: _authProvider.wizardValues.majorId!);
    }
  }

  void _initializeSliderFuture() async {
    _sliderFuture = _mainProvider.fetchMySlider(_authProvider.wizardValues.countryId!);
  }

  void _initializeLearningFuture() async {
    _learningFuture = _mainProvider.fetchMyLearning();
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        setState(() {
          _query = '';
        });
      } else {
        setState(() {
          _query = query;
        });
      }
    });
  }

  void navigateToWizard() {
    switch (_authProvider.wizardValues.wizardType) {
      case WizardType.countries :
         context.push(
          const WizardScreen(
            wizardType: WizardType.countries,
          ),
        );
      case WizardType.universities :
         context.push(
           WizardScreen(
            wizardType: WizardType.universities,
            id: _authProvider.wizardValues.countryId,
            isComeHome: true,
          ),
         );
       case WizardType.colleges :
          context.push(
            WizardScreen(
              wizardType: WizardType.colleges,
              id: _authProvider.wizardValues.universityId,
              isComeHome: true,
            ),
          );
       case WizardType.specialities :
          context.push(
          WizardScreen(
            wizardType: WizardType.colleges,
            id: _authProvider.wizardValues.universityId,
            isComeHome: true,
          ),
        );
    }
  }

  List<cou.Course> search() {
    List<cou.Course> results = <cou.Course>[];
    if (_query.isEmpty) {
      results = majorCourse;
    } else {
      results = majorCourse
          .where((p0) => p0.name!.toLowerCase().contains(_query.toLowerCase()))
          .toList();
    }
    return results;
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
    return  RefreshIndicator(
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
              toolbarHeight: 67,
              leading:  GestureDetector(
                onTap: () => navigateToWizard(),
                child:  MySubscription(
                  isMajor: _authProvider.wizardValues.wizardType == WizardType.specialities,
                ),
                ),
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
                    onRetry: () {
                      setState(() {
                        _initializeSliderFuture();
                      });
                    },
                    onLoading: () => const SliderLoading(),
                    onComplete: (context, snapshot) {
                      final slider = snapshot.data!;
                      return slider.data!.isEmpty
                          ? const SizedBox.shrink()
                          : MySlider(slider: slider.data!);
                    },
                  ),
                  if(_authProvider.wizardValues.wizardType == WizardType.colleges)
                   OnlineProfessors(
                    key: UniqueKey(),
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
                                  return continueLearningData.data!.isEmpty
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
                                                    Text(context.appLocalization.pursueEducation,
                                                      style: const TextStyle(
                                                        fontWeight:FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 110,
                                                child: ListView.separated(
                                                  separatorBuilder: (context,index) => const SizedBox(width: 7),
                                                  itemCount: continueLearningData.data!.length,
                                                  padding: const EdgeInsetsDirectional.only(top: 10, start: 13),
                                                  shrinkWrap: true,
                                                  scrollDirection:Axis.horizontal,
                                                  itemBuilder: (context, index) {
                                                    return EductionCard(
                                                        learningData: continueLearningData.data![index]);
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
                return _authProvider.wizardValues.wizardType == WizardType.specialities
                ? const ShimmerLoading(child: MajorFilterLoading())
                : const ShimmerLoading(child: FilterLoading());
              },
              onComplete: (context, snapshot) {
                late final dynamic filter;
                late final List<dynamic> data;
                late final MajorFilterData major;
                List<dynamic> filterData = [];
                late final List<cou.Professor> professors;
                int? collegeId;

                switch (_authProvider.wizardValues.wizardType) {
                  case WizardType.countries:
                    filter = snapshot.data! as cou.CountryFilterModel;
                    data = filter.data!.universities! as List<cou.University>;
                    professors = filter.data!.professors!;
                  case WizardType.universities:
                    filter = snapshot.data! as un.UniversityFilterModel;
                    data = filter.data!.university!.colleges! as List<un.College>;
                    professors = filter.data!.professors!;
                  case WizardType.colleges:
                    filter = snapshot.data! as CollegeFilterModel;
                    data = filter.data!.majors! as List<Major>;
                    collegeId = filter.data!.college!.id!;
                    professors = filter.data!.professors!;
                  case WizardType.specialities:
                    filter = snapshot.data! as MajorFilterModel;
                    data = filter.data!.major!.courses! as List<cou.Course>;
                    majorCourse = filter.data!.major!.courses! as List<cou.Course>;
                    professors = filter.data!.professors!;
                    major = filter.data!;
                }
                data.map((element) {
                  if (_authProvider.wizardValues.wizardType == WizardType.specialities) {
                    filterData.add(element);
                  } else if (element.courses.isNotEmpty) {
                    filterData.add(element);
                  }
                }).toSet();

                return filterData.isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                          child: Text(context.appLocalization.noCoursesYet),
                        ),
                      )
                    : _authProvider.wizardValues.wizardType == WizardType.specialities
                        ? SliverPadding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            sliver: SliverToBoxAdapter(
                              child: ShrinkWrappingViewport(
                                offset: ViewportOffset.zero(),
                                slivers: [
                                  SliverPadding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    sliver: SliverToBoxAdapter(
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            major.major!.name!,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
                                            child: Row(
                                              children: [
                                                const CustomSvg(MyIcons.teacher),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional.only(start: 5, end: 10),
                                                  child: Text(
                                                    "${major.courseCount} ${context.appLocalization.course}",
                                                    style: TextStyle(
                                                      color: context
                                                          .colorPalette.grey66,
                                                    ),
                                                  ),
                                                ),
                                                const CustomSvg(MyIcons.subscription),
                                                Padding(
                                                  padding:const EdgeInsetsDirectional.only(start: 5),
                                                  child: Text(
                                                    "${major.major!.totalSubscriptions} ${context.appLocalization.subscriber}",
                                                    style: TextStyle(
                                                      color: context.colorPalette.grey66,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          BaseEditor(
                                            hintText: context.appLocalization.searchCourse,
                                            hintStyle: TextStyle(
                                              color: context.colorPalette.grey66,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            initialValue: null,
                                            filled: true,
                                            fillColor: context.colorPalette.white,
                                            prefixIcon: const IconButton(
                                              onPressed: null,
                                              icon: CustomSvg(MyIcons.search),
                                            ),
                                            onChanged: _onSearchChanged,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            context.appLocalization.courses,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: context.colorPalette.black33,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SliverPadding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                    sliver: SliverList.separated(
                                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                                      itemCount: search().length,
                                      itemBuilder: (context, index) {
                                        return CourseCard(course: search()[index]);
                                      },
                                    ),
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
                          )
                        : SliverPadding(
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
                                  if (professors.isNotEmpty)
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
