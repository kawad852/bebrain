import 'package:bebrain/utils/app_constants.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

class DistinguishedLectures extends StatefulWidget {
  const DistinguishedLectures({super.key});

  @override
  State<DistinguishedLectures> createState() => _DistinguishedLecturesState();
}

class _DistinguishedLecturesState extends State<DistinguishedLectures> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  context.appLocalization.distinguishedLecturers,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.colorPalette.black33,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      context.appLocalization.more,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorPalette.grey66,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: context.colorPalette.grey66,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 70,
          child: ListView.separated(
            padding: const EdgeInsetsDirectional.only(top: 10, bottom: 10, start: 10),
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: context.colorPalette.greyEEE,
                  borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                ),
                child: Row(
                  children: [
                    const CustomNetworkImage(
                      kFakeImage,
                      width: 40,
                      height: 40,
                      radius: MyTheme.radiusSecondary,
                    ),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "د. عبدالله محمد",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: context.colorPalette.black33,
                          ),
                        ),
                        Text(
                          "4950 مشترك",
                          style: TextStyle(
                            fontSize: 12,
                            color: context.colorPalette.black33,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
