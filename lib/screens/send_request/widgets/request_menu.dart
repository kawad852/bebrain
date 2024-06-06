import 'package:bebrain/model/wizard_model.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

class RequestMenu extends StatelessWidget {
  final String hintText;
  final List<WizardData> wizardData;
  final void Function(Map<String,int>?)? onSelected;
  const RequestMenu({
    super.key,
    required this.hintText,
    required this.wizardData,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
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
          items: wizardData.map((wizard) {
            return DropdownMenuItem<Map<String,int>>(
                value: {wizard.name!:wizard.id!}, child: Text(wizard.name!));
          }).toList(),
        ),
      ),
    );
  }
}
