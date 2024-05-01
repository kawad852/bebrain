import 'package:bebrain/screens/lecturers/lecturers_screen.dart';
import 'package:bebrain/utils/app_constants.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/more_button.dart';
import 'package:flutter/material.dart';

class DistinguishedLectures extends StatefulWidget {
  final String title;
  const DistinguishedLectures({super.key, required this.title});

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
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.colorPalette.black33,
                  ),
                ),
              ),
              MoreButton(onTap: (){
                context.push(const LecturersScreen());
              }),
            ],
          ),
        ),
        SizedBox(
          height: 75,
          child: ListView.separated(
            padding: const EdgeInsetsDirectional.only(top: 10, bottom: 10, start: 10),
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                width: 160,
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
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
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "د. عبدالله محمد",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: context.colorPalette.black33,
                            ),
                          ),
                          Text(
                            "4950 مشترك",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: context.colorPalette.black33,
                            ),
                          ),
                        ],
                      ),
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
