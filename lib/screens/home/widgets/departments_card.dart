import 'package:bebrain/screens/department/department_screen.dart';
import 'package:bebrain/utils/app_constants.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/evaluation_star.dart';
import 'package:bebrain/widgets/more_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DepartmentsCard extends StatefulWidget {
  const DepartmentsCard({super.key});

  @override
  State<DepartmentsCard> createState() => _DepartmentsCardState();
}

class _DepartmentsCardState extends State<DepartmentsCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "كلية الملك عبدالله",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.colorPalette.black33,
                  ),
                ),
              ),
              MoreButton(
                onTap: () {
                  context.push(const DepartmentScreen());
                },
              ),
            ],
          ),
        ),
        CarouselSlider.builder(
          itemCount: 5,
          options: CarouselOptions(
            padEnds: false,
            viewportFraction: 0.8,
            enableInfiniteScroll: false,
            height: 220,
            onPageChanged: (index, reason) {},
          ),
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: const EdgeInsetsDirectional.only(top: 5, start: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomNetworkImage(
                    kFakeImage,
                    width: 272,
                    height: 180,
                    alignment: Alignment.topLeft,
                    radius: MyTheme.radiusSecondary,
                    child: EvaluationStar(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      evaluation: "4.8",
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "اساسيات البرمجة المتقدمة",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: context.colorPalette.black33,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "د. احمد محمد",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: context.colorPalette.grey66,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(
          height: 50,
          child: ListView.separated(
            padding: const EdgeInsetsDirectional.only( start: 10, top: 10, bottom: 10),
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                height: 34,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: context.colorPalette.greyEEE,
                  borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                ),
                child: Text(
                  "نظم المعلومات الحاسوبية",
                  style: TextStyle(
                    color: context.colorPalette.grey66,
                    fontSize: 12,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
