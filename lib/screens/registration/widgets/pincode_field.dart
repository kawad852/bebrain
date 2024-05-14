import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const PinCodeField({
    Key? key,
    required this.controller,
    this.keyboardType,
  }) : super(key: key);

  PinTheme _getTheme(BuildContext context) {
    final color = context.colorPalette.greyBFB;
    final borderColor = context.colorPalette.greyF2F;
    return PinTheme(
      shape: PinCodeFieldShape.box,
      borderWidth: 0.5,
      borderRadius: BorderRadius.circular(10),
      fieldHeight: 46,
      fieldWidth: 46,
      activeFillColor: color,
      activeColor: borderColor,
      inactiveColor: borderColor,
      selectedColor: borderColor,
      inactiveFillColor: color,
      selectedFillColor: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        controller: controller,
        length: 6,
        animationType: AnimationType.fade,
        enableActiveFill: true,
        pinTheme: _getTheme(context),
        keyboardType: keyboardType ?? TextInputType.number,
        cursorColor: context.colorScheme.primary,
        animationDuration: const Duration(milliseconds: 300),
        autoDisposeControllers: true,
      ),
    );
  }
}
