import 'package:bebrain/screens/department/department_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/widgets/courses_list.dart';
import 'package:bebrain/widgets/more_button.dart';
import 'package:flutter/material.dart';

class DepartmentsCard extends StatefulWidget {
  final dynamic data;
  const DepartmentsCard({super.key, required this.data});

  @override
  State<DepartmentsCard> createState() => _DepartmentsCardState();
}

class _DepartmentsCardState extends State<DepartmentsCard> {

  int getLengthData() {
    switch (MySharedPreferences.filter.wizardType) {
      case WizardType.countries:
        return widget.data.colleges!.length;
      case WizardType.universities:
        return widget.data.majors!.length;
      default:
        return 0;
    }
  }

  String getName(int index) {
    switch (MySharedPreferences.filter.wizardType) {
      case WizardType.countries:
        return widget.data.colleges![index].name!;
      case WizardType.universities:
        return widget.data.majors![index].name!;
      default:
        return "";
    }
  }

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
                  widget.data.name!,
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
        CoursesList(courses: widget.data.courses!),
        if (MySharedPreferences.filter.wizardType != WizardType.colleges &&
            MySharedPreferences.filter.wizardType != WizardType.specialities)
          SizedBox(
            height: 50,
            child: ListView.separated(
              padding: const EdgeInsetsDirectional.only(
                  start: 10, top: 10, bottom: 10),
              separatorBuilder: (context, index) => const SizedBox(width: 5),
              itemCount: getLengthData(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  height: 34,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: context.colorPalette.greyEEE,
                    borderRadius:
                        BorderRadius.circular(MyTheme.radiusSecondary),
                  ),
                  child: Text(
                    getName(index),
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
