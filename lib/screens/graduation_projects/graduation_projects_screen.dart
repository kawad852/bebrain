import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/widgets/custom_form.dart';
import 'package:flutter/material.dart';

class GraduationProjectsScreen extends StatefulWidget {
  const GraduationProjectsScreen({super.key});

  @override
  State<GraduationProjectsScreen> createState() =>
      _GraduationProjectsScreenState();
}

class _GraduationProjectsScreenState extends State<GraduationProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: context.appLocalization.projects,
      description: context.appLocalization.requestYourProject,
      isGraduationProjects: true,
    );
  }
}
