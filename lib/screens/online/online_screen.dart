import 'package:bebrain/model/important_subject_model.dart';
import 'package:bebrain/model/online_professor_model.dart';
import 'package:bebrain/model/teacher_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/lecturers/widgets/lectures_loading.dart';
import 'package:bebrain/screens/online/widgets/subject_loading.dart';
import 'package:bebrain/screens/online/widgets/teacher_card.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/editors/base_editor.dart';
import 'package:bebrain/widgets/shimmer/shimmer_loading.dart';
import 'package:bebrain/widgets/vex/vex_loader.dart';
import 'package:bebrain/widgets/vex/vex_paginator.dart';
import 'package:flutter/material.dart';

class OnlineScreen extends StatefulWidget {
  const OnlineScreen({super.key});

  @override
  State<OnlineScreen> createState() => _OnlineScreenState();
}

class _OnlineScreenState extends State<OnlineScreen>
    with AutomaticKeepAliveClientMixin {
  late MainProvider _mainProvider;
  late Future<ImportantSubjectModel> _subjectFuture;
  late Future<OnlineProfessorModel> _professorsFuture;
  final _vexKey = GlobalKey<VexPaginatorState>();
  String _query = '';
  int? _subjectId;
  bool isSubject = false;

  void _initializeFuture() async {
    _subjectFuture = _mainProvider.fetchImportantSubject(_query);
  }

  Future<OnlineProfessorModel> _initializeOnlineProfessorsFuture(int pageKey) {
    _professorsFuture = isSubject
        ? _mainProvider.fetchProfessorBySubjectId(pageKey: pageKey, id: _subjectId!)
        : _mainProvider.fetchOnlineProfessor(
            pageKey: pageKey,
            value: _query,
          );
    return _professorsFuture;
  }

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              isSubject = false;
              _initializeFuture();
            });
            _vexKey.currentState!.refresh();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 25, bottom: 5),
                      child: Text(
                        context.appLocalization.bookLectureOnline,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: BaseEditor(
                        hintText: context.appLocalization.searchSubOrLecture,
                        initialValue: null,
                        filled: true,
                        fillColor: context.colorPalette.white,
                        prefixIcon: const IconButton(
                          onPressed: null,
                          icon: CustomSvg(MyIcons.search),
                        ),
                        onChanged: (value) {
                          setState(() {
                            isSubject = false;
                            _query = value;
                            _initializeFuture();
                          });
                          _vexKey.currentState!.refresh();
                        },
                      ),
                    ),
                    CustomFutureBuilder(
                      future: _subjectFuture,
                      onRetry: () {
                        setState(() {
                          _initializeFuture();
                        });
                      },
                      onLoading: () => const ShimmerLoading(child: SubjectLoading()),
                      onComplete: (context, snapshot) {
                        final subject = snapshot.data!;
                        return Wrap(
                          direction: Axis.horizontal,
                          children: subject.data!.map(
                            (item) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _subjectId = item.id!;
                                        isSubject = true;
                                      });
                                      _vexKey.currentState!.refresh();
                                    },
                                    child: Container(
                                      height: 34,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: context.colorPalette.blueC2E,
                                        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                                      ),
                                      child: Text(
                                        item.name!,
                                        style: TextStyle(
                                          color: context.colorPalette.black33,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              VexPaginator(
                key: _vexKey,
                query: (pageKey) async => _initializeOnlineProfessorsFuture(pageKey),
                onFetching: (snapshot) async => snapshot.data!,
                pageSize: 10,
                sliver: true,
                onLoading: () => const ShimmerLoading(child: LecturesLoading(isOnLine: true)),
                builder: (context, snapshot) {
                  final professors = snapshot.docs as List<TeacherData>;
                  return professors.isEmpty
                      ? SliverFillRemaining(
                          child: Center(
                            child: Text(context.appLocalization.noTeacherYet),
                          ),
                        )
                      : SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2),
                          ),
                          delegate: SliverChildBuilderDelegate(
                            childCount: snapshot.docs.length + 1,
                            (context, index) {
                              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                                snapshot.fetchMore();
                              }

                              if (index == snapshot.docs.length) {
                                return VexLoader(snapshot.isFetchingMore);
                              }
                              final element = professors[index];
                              return TeacherCard(teacherData: element);
                            },
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
