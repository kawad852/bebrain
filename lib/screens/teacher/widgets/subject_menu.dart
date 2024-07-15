import 'package:bebrain/model/teacher_model.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

class SubjectMenu extends StatelessWidget {
  final String hintText;
  final List<Subject> subjects;
  final void Function(Map<String,int>?)? onSelected;
  const SubjectMenu({
    super.key,
    required this.hintText, 
    required this.subjects, 
    this.onSelected,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: context.colorPalette.white,
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        border: Border.all(
          color: context.colorPalette.greyF2F,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: DropdownButton(
          isExpanded: true,
          hint: Text(
            hintText,
            style: TextStyle(
              color: context.colorPalette.greyDBD,
              fontSize: 14,
            ),
          ),
          underline: const SizedBox(),
          icon: const CustomSvg(MyIcons.arrowDown),
          onChanged: onSelected,
          items: subjects.map((subject) {
            return DropdownMenuItem<Map<String,int>>(
                value: {subject.name!:subject.id!}, child: Text(subject.name!));
          }).toList(),
        ),
      ),
    );
  }
}