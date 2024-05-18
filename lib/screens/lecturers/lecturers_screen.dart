import 'package:bebrain/model/professors_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/lecturers/widgets/lectures_loading.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/editors/base_editor.dart';
import 'package:bebrain/widgets/evaluation_star.dart';
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
  final _vexKey = GlobalKey<VexPaginatorState>();

  Future<ProfessorsModel> _initializeFuture(int pageKey) {
    _professorsFuture = _mainProvider.fetchProfessors(pageKey);
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
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          VexPaginator(
            key: _vexKey,
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, 
                      childAspectRatio: 0.9,
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
                      return Container(
                        height: 185,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          color: context.colorPalette.greyEEE,
                          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                        ),
                        child: Column(
                          children: [
                            CustomNetworkImage(
                              element.image!,
                              width: 91,
                              height: 91,
                              shape: BoxShape.circle,
                              alignment: context.isLTR
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: const EvaluationStar(
                                evaluation: "4.8",
                              ),
                            ),
                            Flexible(
                              child: Text(
                                element.name!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                element.universityName!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: context.colorPalette.grey66,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                "4900 ${context.appLocalization.subscriber}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: context.colorPalette.grey66,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
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
