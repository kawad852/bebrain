import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/widgets/custom_form.dart';
import 'package:flutter/material.dart';

class DutiesScreen extends StatefulWidget {
  const DutiesScreen({super.key});

  @override
  State<DutiesScreen> createState() => _DutiesScreenState();
}

class _DutiesScreenState extends State<DutiesScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: context.appLocalization.duties,
      description: context.appLocalization.requestSolveAssignment,
    );
  }
}
