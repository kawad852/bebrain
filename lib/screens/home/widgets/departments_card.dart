import 'package:bebrain/model/country_filter_model.dart';
import 'package:bebrain/screens/department/department_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/courses_list.dart';
import 'package:bebrain/widgets/more_button.dart';
import 'package:flutter/material.dart';

class DepartmentsCard extends StatefulWidget {
  final University university;
  const DepartmentsCard({super.key, required this.university});

  @override
  State<DepartmentsCard> createState() => _DepartmentsCardState();
}

class _DepartmentsCardState extends State<DepartmentsCard> {
  University get _university => widget.university;
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
                  _university.name!,
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
         CoursesList(courses: _university.courses!),
        SizedBox(
          height: 50,
          child: ListView.separated(
            padding: const EdgeInsetsDirectional.only( start: 10, top: 10, bottom: 10),
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            itemCount: _university.colleges!.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final college=_university.colleges![index];
              return Container(
                height: 34,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: context.colorPalette.greyEEE,
                  borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                ),
                child: Text(
                  college.name!,
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
