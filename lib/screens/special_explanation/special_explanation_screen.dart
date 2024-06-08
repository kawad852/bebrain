import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/widgets/custom_form.dart';
import 'package:flutter/material.dart';

class SpecialExplanationScreen extends StatefulWidget {
  const SpecialExplanationScreen({super.key});

  @override
  State<SpecialExplanationScreen> createState() =>
      _SpecialExplanationScreenState();
}

class _SpecialExplanationScreenState extends State<SpecialExplanationScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomForm(
      formEnum: FormEnum.studyExplanation,
      title: context.appLocalization.explanation,
      description: context.appLocalization.partNotUnderstood,
    );
  }
}
