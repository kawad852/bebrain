import 'package:bebrain/screens/department/widgets/text_course.dart';
import 'package:bebrain/utils/app_constants.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/evaluation_star.dart';
import 'package:flutter/material.dart';

class ArticleSubscriptionsScreen extends StatefulWidget {
  const ArticleSubscriptionsScreen({super.key});

  @override
  State<ArticleSubscriptionsScreen> createState() =>
      _ArticleSubscriptionsScreenState();
}

class _ArticleSubscriptionsScreenState
    extends State<ArticleSubscriptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(pinned: true),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Text(
                context.appLocalization.articleSubscriptions,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 110,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? context.colorPalette.blueE4F
                          : context.colorPalette.greyF2F,
                      borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                      border: Border.all(
                        color: context.colorPalette.greyF2F,
                      ),
                    ),
                    child: Row(
                      children: [
                        CustomNetworkImage(
                          kFakeImage,
                          width: 90,
                          height: 90,
                          radius: MyTheme.radiusSecondary,
                          alignment: context.isLTR ? Alignment.topLeft : Alignment.topRight,
                          child: const EvaluationStar(
                            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            evaluation: "4.8",
                          ),
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCourse(
                                "اساسيات البرمجة المتقدمة",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: context.colorPalette.black33,
                              ),
                              const TextCourse(
                                "د.اجمد محمد",
                                fontSize: 14,
                              ),
                              TextCourse(
                                "الاشتراك فعال حتى تاريخ 05/05/2024",
                                color: context.colorPalette.green008,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const CustomSvg(MyIcons.video),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(start: 5, end: 8),
                                    child: TextCourse("5 ${context.appLocalization.video}"),
                                  ),
                                  const CustomSvg(MyIcons.axes),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(start: 5),
                                    child: TextCourse("5 ${context.appLocalization.axes}"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
