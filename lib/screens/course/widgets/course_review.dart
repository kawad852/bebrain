import 'package:bebrain/model/course_review_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/course/widgets/rating_card.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/vex/vex_loader.dart';
import 'package:bebrain/widgets/vex/vex_paginator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CourseReview extends StatefulWidget {
  final int courseId;
  const CourseReview({super.key, required this.courseId});

  @override
  State<CourseReview> createState() => _CourseReviewState();
}

class _CourseReviewState extends State<CourseReview> {
  late MainProvider _mainProvider;
  late Future<CourseReviewModel> _courseReviewsFuture;
  final _vexKey = GlobalKey<VexPaginatorState>();

  Future<CourseReviewModel> _initializeFuture(int pageKey) {
    _courseReviewsFuture = _mainProvider.fetchCourseReviews(
      pageKey: pageKey,
      courseId: widget.courseId,
    );
    return _courseReviewsFuture;
  }

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VexPaginator(
        key: _vexKey,
        query: (pageKey) async => _initializeFuture(pageKey),
        onFetching: (snapshot) async => snapshot.data!,
        pageSize: 10,
        builder: (context, snapshot) {
          final data = snapshot.docs as List<ReviewData>;
          return data.isEmpty
              ? Center(
                child: Text(
                    context.appLocalization.noReviewsYet,
                    style: TextStyle(
                      color: context.colorPalette.black33,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              )
              : ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  shrinkWrap: true,
                  itemCount: snapshot.docs.length + 1,
                  itemBuilder: (context, index) {
                    if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                      snapshot.fetchMore();
                    }

                    if (index == snapshot.docs.length) {
                      return VexLoader(snapshot.isFetchingMore);
                    }
                    final review = data[index];
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: context.colorPalette.greyEEE,
                        borderRadius:BorderRadius.circular(MyTheme.radiusSecondary),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomNetworkImage(
                                review.userImage?? "",
                                width: 40,
                                height: 40,
                                shape: BoxShape.circle,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.userName!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: context.colorPalette.black33,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      DateFormat("dd/MM/yyyy").format(review.createdAt!),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: context.colorPalette.black33,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            review.comment!,
                            style: TextStyle(
                              color: context.colorPalette.black33,
                              fontSize: 12,
                            ),
                          ),
                          RatingCard(
                            audioVideoRating: double.parse(review.audioVideoQuality!),
                            conveyIdea: double.parse(review.conveyIdea!),
                            similarityCurriculumContent: double.parse(review.similarityCurriculumContent!),
                            valueForMoney: double.parse(review.valueForMoney!),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
