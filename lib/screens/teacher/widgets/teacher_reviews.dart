import 'package:bebrain/model/teacher_evalution_model.dart';
import 'package:bebrain/model/teacher_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/teacher/widgets/rate_card.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/widgets/vex/vex_loader.dart';
import 'package:bebrain/widgets/vex/vex_paginator.dart';
import 'package:flutter/material.dart';

class TeacherReviews extends StatefulWidget {
  final int professorId;
  const TeacherReviews({super.key, required this.professorId});

  @override
  State<TeacherReviews> createState() => _TeacherReviewsState();
}

class _TeacherReviewsState extends State<TeacherReviews> {
  late MainProvider _mainProvider;
  late Future<TeacherEvalutionModel> _teacherReviewsFuture;
  final _vexKey = GlobalKey<VexPaginatorState>();

  Future<TeacherEvalutionModel> _initializeFuture(int pageKey) {
    _teacherReviewsFuture = _mainProvider.fetchProfessorReviews(
      pageKey: pageKey,
      professorId: widget.professorId,
    );
    return _teacherReviewsFuture;
  }

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
  }

  @override
  Widget build(BuildContext context) {
    return VexPaginator(
      key: _vexKey,
      query: (pageKey) async => _initializeFuture(pageKey),
      onFetching: (snapshot) async => snapshot.data!,
      pageSize: 10,
      builder: (context, snapshot) {
        final reviews = snapshot.docs as List<Review>;
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverList.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                  itemCount: snapshot.docs.length + 1,
                  itemBuilder: (context, index) {
                    if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                      snapshot.fetchMore();
                    }

                    if (index == snapshot.docs.length) {
                      return VexLoader(snapshot.isFetchingMore);
                    }
                    return RateCard(review: reviews[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
