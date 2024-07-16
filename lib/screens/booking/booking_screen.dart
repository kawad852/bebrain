import 'dart:async';

import 'package:bebrain/model/interview_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/booking/widgets/previous_booking.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/editors/base_editor.dart';
import 'package:bebrain/widgets/shimmer/shimmer_bubble.dart';
import 'package:bebrain/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late MainProvider _mainProvider;
  late Future<InterviewModel> _interviewFuture;
  Timer? _debounce;
  String _query = '';

  void _initializeFuture() {
    _interviewFuture = _mainProvider.fetchMyInterViews();
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
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _initializeFuture();
          });
        },
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(pinned: true),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.appLocalization.appointmentsAndBookings,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        context.appLocalization.doYouNeedOnlineLecture,
                        style: TextStyle(
                          color: context.colorPalette.grey66,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomFutureBuilder(
              future: _interviewFuture,
              onRetry: () {
                setState(() {
                  _initializeFuture();
                });
              },
              sliver: true,
              onLoading: () {
                return ShimmerLoading(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LoadingBubble(
                        width: double.infinity,
                        height: 50,
                        radius: MyTheme.radiusSecondary,
                      ),
                      const LoadingBubble(
                        width: 100,
                        height: 30,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        radius: MyTheme.radiusPrimary,
                      ),
                      ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(height: 5),
                        padding: EdgeInsets.zero,
                        itemCount: 8,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return const LoadingBubble(
                            width: double.infinity,
                            height: 60,
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
                            radius: MyTheme.radiusSecondary,
                          );
                        },
                      ),
                    ],
                  ),
                ));
              },
              onComplete: (context, snapshot) {
                final myInterView = snapshot.data!;
                var data = <InterviewData>[];
                if (_query.isEmpty) {
                  data = snapshot.data!.data!;
                } else {
                  data = List<InterviewData>.from(snapshot.data!.data!
                      .where(
                        (element) {
                          if (context.languageCode == LanguageEnum.arabic) {
                            return element.professorName!.contains(_query);
                          }
                          return element.professorName!
                              .toLowerCase()
                              .contains(_query.toLowerCase());
                        },
                      )
                      .toList()
                      .map((x) => InterviewData.fromJson(x.toJson())));
                }
                return myInterView.data!.isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                          child: Text(context.appLocalization.noRequestyet),
                        ),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        sliver: SliverToBoxAdapter(
                          child: ShrinkWrappingViewport(
                            offset: ViewportOffset.zero(),
                            slivers: [
                              SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BaseEditor(
                                      hintText: context.appLocalization.searchLectureName,
                                      initialValue: null,
                                      filled: true,
                                      fillColor: context.colorPalette.white,
                                      prefixIcon: const IconButton(
                                        onPressed: null,
                                        icon: CustomSvg(MyIcons.search),
                                      ),
                                      onChanged: _onSearchChanged,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        context.appLocalization.previousBookings,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SliverList.separated(
                                separatorBuilder: (context, index) => const SizedBox(height: 5),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return PreviousBooking(interviewData: data[index]);
                                },
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
}
