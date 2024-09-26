import 'package:bebrain/model/professors_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/lecturers/widgets/lecture_card.dart';
import 'package:bebrain/screens/lecturers/widgets/lectures_loading.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/editors/base_editor.dart';
import 'package:bebrain/widgets/shimmer/shimmer_loading.dart';
import 'package:bebrain/widgets/vex/vex_loader.dart';
import 'package:bebrain/widgets/vex/vex_paginator.dart';
import 'package:flutter/material.dart';

class LecturersScreen extends StatefulWidget {
  const LecturersScreen({super.key});

  @override
  State<LecturersScreen> createState() => _LecturersScreenState();
}

class _LecturersScreenState extends State<LecturersScreen> {
  late MainProvider _mainProvider;
  late Future<ProfessorsModel> _professorsFuture;
  // final _vexKey = GlobalKey<VexPaginatorState>();
  bool search = false;
  String _query = '';
  Future<ProfessorsModel> _initializeFuture(int pageKey) {
    _professorsFuture = _mainProvider.fetchProfessors(pageKey);
    return _professorsFuture;
  }

  Future<ProfessorsModel> _search(int pageKey) {
    _professorsFuture = _mainProvider.searchProfessors(pageKey, _query);
    return _professorsFuture;
  }

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(pinned: true),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.appLocalization.lecturers,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: BaseEditor(
                      hintText: context.appLocalization.searchLectureName,
                      initialValue: null,
                      filled: true,
                      fillColor: context.colorPalette.white,
                      prefixIcon: const IconButton(
                        onPressed: null,
                        icon: CustomSvg(MyIcons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _query = value;

                          if (value.isNotEmpty) {
                            search = true;
                          } else {
                            search = false;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!search)
            VexPaginator(
              query: (pageKey) async => _initializeFuture(pageKey),
              onFetching: (snapshot) async => snapshot.data!,
              pageSize: 10,
              sliver: true,
              onLoading: () => const ShimmerLoading(child: LecturesLoading()),
              builder: (context, snapshot) {
                final professors = snapshot.docs as List<ProfessorData>;
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  sliver: SliverGrid(
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (MediaQuery.of(context).size.width / 170).toInt(),
                      childAspectRatio: 170 / 185,
                      
                    ),
                    delegate: SliverChildBuilderDelegate(
                      childCount: snapshot.docs.length + 1,
                      (context, index) {
                        if (snapshot.hasMore &&
                            index + 1 == snapshot.docs.length) {
                          snapshot.fetchMore();
                        }

                        if (index == snapshot.docs.length) {
                          return VexLoader(snapshot.isFetchingMore);
                        }
                        final element = professors[index];
                        return LectureCard(professor: element);
                      },
                    ),
                  ),
                );
              },
            ),
          if (search)
            VexPaginator(
              key: UniqueKey(),
              query: (pageKey) async => _search(pageKey),
              onFetching: (snapshot) async => snapshot.data!,
              pageSize: 10,
              sliver: true,
              onLoading: () => const ShimmerLoading(child: LecturesLoading()),
              builder: (context, snapshot) {
                final professors = snapshot.docs as List<ProfessorData>;
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (MediaQuery.of(context).size.width / 170).toInt(),
                      childAspectRatio: 170 / 185,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      childCount: snapshot.docs.length + 1,
                      (context, index) {
                        if (snapshot.hasMore &&
                            index + 1 == snapshot.docs.length) {
                          snapshot.fetchMore();
                        }

                        if (index == snapshot.docs.length) {
                          return VexLoader(snapshot.isFetchingMore);
                        }
                        final element = professors[index];
                        return LectureCard(professor: element);
                      },
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
