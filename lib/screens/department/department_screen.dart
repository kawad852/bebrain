
import 'dart:async';
import 'package:bebrain/model/country_filter_model.dart';
import 'package:bebrain/model/major_filter_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/department/widgets/course_card.dart';
import 'package:bebrain/screens/department/widgets/department_loading.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/distinguished_lectures.dart';
import 'package:bebrain/widgets/editors/base_editor.dart';
import 'package:flutter/material.dart';

class DepartmentScreen extends StatefulWidget {
  final int collegeId;
  final int majorId;
  const DepartmentScreen(
      {super.key, required this.collegeId, required this.majorId});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  late MainProvider _mainProvider;
  late Future<MajorFilterModel> _majorFuture;
  Timer? _debounce;
  String _query = '';

  void _initializeFuture() async {
    _majorFuture = _mainProvider.filterByMajor(collegeId: widget.collegeId, majorId: widget.majorId);
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

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomFutureBuilder(
        future: _majorFuture,
        onRetry: () {
          setState(() {
            _initializeFuture();
          });
        },
        onLoading: (){
          return const DepartmentLoading();
        },
        onComplete: (context, snapshot) {
          final majorFilter = snapshot.data!;
          final major = majorFilter.data!;
          var data = <Course>[];
        if (_query.isEmpty) {
          data = snapshot.data!.data!.major!.courses!;
        } else {
          data = List<Course>.from(snapshot.data!.data!.major!.courses!
              .where(
                (element) {
                  if (context.languageCode == LanguageEnum.arabic) {
                    return element.name!.contains(_query);
                  }
                  return element.name!.toLowerCase().contains(_query.toLowerCase());
                },
              )
              .toList()
              .map((x) => Course.fromJson(x.toJson())));
        }
          return CustomScrollView(
            slivers: [
              const SliverAppBar(pinned: true),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        major.major!.name!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const CustomSvg(MyIcons.teacher),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 5, end: 10),
                              child: Text(
                                "${major.courseCount} ${context.appLocalization.course}",
                                style: TextStyle(
                                  color: context.colorPalette.grey66,
                                ),
                              ),
                            ),
                            const CustomSvg(MyIcons.subscription),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 5),
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
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DistinguishedLectures(
                        title: context.appLocalization.lecturers,
                        professors: major.professors!,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          context.appLocalization.courses,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.colorPalette.black33,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverList.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return CourseCard(course: data[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
