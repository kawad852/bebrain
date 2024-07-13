import 'package:bebrain/model/projects_model.dart';
import 'package:bebrain/network/api_url.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/send_request/send_request_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/previous_request.dart';
import 'package:bebrain/widgets/shimmer/shimmer_bubble.dart';
import 'package:bebrain/widgets/shimmer/shimmer_loading.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomForm extends StatefulWidget {
  final String title;
  final String description;
  final bool isGraduationProjects;
  final String formEnum;
  const CustomForm({
    super.key,
    required this.title,
    required this.description,
    this.isGraduationProjects = false,
    required this.formEnum,
  });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> with AutomaticKeepAliveClientMixin {
  late MainProvider _mainProvider;
  late Future<ProjectsModel> _myRequestFuture;

  void _initializeFuture() async {
    switch (widget.formEnum) {
      case FormEnum.project:
        _myRequestFuture = _mainProvider.fetchMyRequest(ApiUrl.projects);
      case FormEnum.assignment:
        _myRequestFuture = _mainProvider.fetchMyRequest(ApiUrl.assignments);
      case FormEnum.studyExplanation:
        _myRequestFuture = _mainProvider.fetchMyRequest(ApiUrl.explanations);
    }
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _initializeFuture();
              });
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
                          widget.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        widget.description,
                        style: TextStyle(
                          color: context.colorPalette.grey66,
                          fontSize: 14,
                        ),
                      ),
                      StretchedButton(
                        onPressed: () async {
                          await context.push(SendRequestScreen(formEnum: widget.formEnum))
                              .then((value) {
                            setState(() {
                              _initializeFuture();
                            });
                          });
                        },
                        margin: const EdgeInsetsDirectional.only(top: 25, bottom: 10),
                        child: Row(
                          children: [
                            const CustomSvg(MyIcons.message),
                            const Expanded(child: SizedBox.shrink()),
                            Text(
                              widget.isGraduationProjects
                                  ? context.appLocalization.projectRequest
                                  : context.appLocalization.sendNewRequest,
                              style: TextStyle(
                                fontSize: 16,
                                color: context.colorPalette.black33,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Expanded(child: SizedBox.shrink()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CustomFutureBuilder(
                  future: _myRequestFuture,
                  onLoading: () {
                    return ShimmerLoading(
                        child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 5),
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
                    ));
                  },
                  onRetry: () {
                    setState(() {
                      _initializeFuture();
                    });
                  },
                  sliver: true,
                  onComplete: (context, snapshot) {
                    final myRequest = snapshot.data!;
                    return myRequest.data!.isEmpty
                        ? SliverFillRemaining(
                            child: Center(
                              child: Text(context.appLocalization.noRequestyet),
                            ),
                          )
                        : SliverToBoxAdapter(
                            child: ShrinkWrappingViewport(
                            offset: ViewportOffset.zero(),
                            slivers: [
                              SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.appLocalization.previousRequests,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              SliverList.separated(
                                separatorBuilder: (context, index) => const SizedBox(height: 5),
                                itemCount: myRequest.data!.length,
                                itemBuilder: (context, index) {
                                  return PreviousRequest(request: myRequest.data![index]);
                                },
                              ),
                            ],
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
