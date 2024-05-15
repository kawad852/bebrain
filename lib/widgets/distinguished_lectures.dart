import 'package:bebrain/model/country_filter_model.dart';
import 'package:bebrain/screens/lecturers/lecturers_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/more_button.dart';
import 'package:flutter/material.dart';

class DistinguishedLectures extends StatelessWidget {
  final String title;
  final List<Professor> professors;
  const DistinguishedLectures({super.key, required this.title, required this.professors});

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
                  title,
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
            itemCount: professors.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final professor=professors[index];
              return Container(
                width: 160,
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                  color: context.colorPalette.greyEEE,
                  borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                ),
                child: Row(
                  children: [
                     CustomNetworkImage(
                      professor.image!,
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
                            professor.name!,
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
