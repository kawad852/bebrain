import 'package:bebrain/helper/ui_helper.dart';
import 'package:bebrain/model/filter_model.dart';
import 'package:bebrain/screens/department/department_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/courses_list.dart';
import 'package:bebrain/widgets/more_button.dart';
import 'package:flutter/material.dart';

class DepartmentsCard extends StatefulWidget {
  final dynamic data;
  final void Function() onTapSubData;
  final int? collegeId;
  const DepartmentsCard(
      {super.key, required this.data, required this.onTapSubData, required this.collegeId});

  @override
  State<DepartmentsCard> createState() => _DepartmentsCardState();
}

class _DepartmentsCardState extends State<DepartmentsCard> {
  int getLengthData() {
    switch (context.authProvider.wizardValues.wizardType) {
      case WizardType.countries:
        return widget.data.colleges!.length;
      case WizardType.universities:
        return widget.data.majors!.length;
      default:
        return 0;
    }
  }

  String getName(int index) {
    switch (context.authProvider.wizardValues.wizardType) {
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
                  if(context.authProvider.wizardValues.wizardType==WizardType.countries){
                    UiHelper.addFilter(context, 
                    filterModel:FilterModel(
                      wizardType: WizardType.universities,
                      countryId: context.authProvider.wizardValues.countryId,
                      countryCode:context.authProvider.wizardValues.countryCode ,
                      countryName: context.authProvider.wizardValues.countryName,
                      universityId: widget.data!.id!,
                      universityName: widget.data.name!,
                    ),
                    afterAdd: widget.onTapSubData,
                    );
                  }
                  else if(context.authProvider.wizardValues.wizardType==WizardType.universities){
                    UiHelper.addFilter(context, 
                    filterModel:FilterModel(
                      wizardType: WizardType.colleges,
                      countryId: context.authProvider.wizardValues.countryId,
                      countryName: context.authProvider.wizardValues.countryName,
                      countryCode: context.authProvider.wizardValues.countryCode,
                      universityId: context.authProvider.wizardValues.universityId,
                      universityName: context.authProvider.wizardValues.universityName,
                      collegeId: widget.data!.id!,
                      collegeName: widget.data.name!,
                    ),
                    afterAdd: widget.onTapSubData,
                    );
                  }
                  else{
                    context.push( 
                      DepartmentScreen(
                        collegeId: widget.collegeId!,
                        majorId: widget.data!.id!,
                    ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        CoursesList(courses: widget.data.courses!),
        if (context.authProvider.wizardValues.wizardType != WizardType.colleges &&
            context.authProvider.wizardValues.wizardType != WizardType.specialities)
          SizedBox(
            height: 50,
            child: ListView.separated(
              padding: const EdgeInsetsDirectional.only(start: 10, top: 10, bottom: 10),
              separatorBuilder: (context, index) => const SizedBox(width: 5),
              itemCount: getLengthData(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (context.authProvider.wizardValues.wizardType == WizardType.countries) {
                      UiHelper.addFilter(
                        context,
                        filterModel: FilterModel(
                            wizardType: WizardType.colleges,
                            countryId: context.authProvider.wizardValues.countryId,
                            countryName: context.authProvider.wizardValues.countryName,
                            countryCode:context.authProvider.wizardValues.countryCode ,
                            universityId: widget.data.id!,
                            universityName: widget.data.name!,
                            collegeId: widget.data.colleges[index].id!,
                            collegeName: widget.data.colleges[index].name!,
                            ),
                        afterAdd: widget.onTapSubData,
                      );
                    } else if (context.authProvider.wizardValues.wizardType == WizardType.universities) {
                      context.push(
                        DepartmentScreen(
                          collegeId: widget.data.id!,
                          majorId: widget.data.majors[index].id!,
                        ),
                      );
                    }
                  },
                  child: Container(
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
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
