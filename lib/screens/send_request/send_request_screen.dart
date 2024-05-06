import 'dart:io';

import 'package:bebrain/screens/send_request/widgets/request_menu.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/editors/base_editor.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:bebrain/widgets/titled_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SendRequestScreen extends StatefulWidget {
  final FormEnum formEnum;
  const SendRequestScreen({super.key, required this.formEnum});

  @override
  State<SendRequestScreen> createState() => _SendRequestScreenState();
}

class _SendRequestScreenState extends State<SendRequestScreen> {
  FilePickerResult? result;
  List<File> files = [];

  void _selectFiles() async {
    result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf'],
    );
    if (result != null) {
      files = result!.paths.map((path) => File(path!)).toList();
      setState(() {});
    }
  }

  String descriptipnPage() {
    switch (widget.formEnum) {
      case FormEnum.duties:
        return context.appLocalization.requestSolveAssignmentAndSendRequest;
      case FormEnum.specialExplanation:
        return context.appLocalization.requestExplainArtical;
      case FormEnum.graduationProjects:
        return context.appLocalization.requestGraduationProject;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(pinned: true),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.appLocalization.sendRequest,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                     descriptipnPage(),
                      style: TextStyle(
                        color: context.colorPalette.grey66,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  TitledTextField(
                    title: context.appLocalization.country,
                    child: RequestMenu(
                      hintText: context.appLocalization.selectCountry,
                    ),
                  ),
                  TitledTextField(
                    title: context.appLocalization.university,
                    child: RequestMenu(
                      hintText: context.appLocalization.selectUniversity,
                    ),
                  ),
                  TitledTextField(
                    title: context.appLocalization.college,
                    child: RequestMenu(
                      hintText: context.appLocalization.selectCollege,
                    ),
                  ),
                  TitledTextField(
                    title: context.appLocalization.specialization,
                    child: RequestMenu(
                      hintText: context.appLocalization.selectSpecialization,
                    ),
                  ),
                  TitledTextField(
                    title: context.appLocalization.title,
                    child:  BaseEditor(
                      hintText: context.appLocalization.titleOfReportOrResarch,
                      initialValue: null,
                      onChanged: (value) {},
                    ),
                  ),
                  TitledTextField(
                    title: context.appLocalization.notes,
                    child: BaseEditor(
                      hintText: context.appLocalization.descriptionAboutAssignment,
                      maxLines: 4,
                      initialValue: null,
                      onChanged: (value) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () {
                        _selectFiles();
                      },
                      child: Row(
                        children: [
                          const CustomSvg(MyIcons.attach),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context
                                      .appLocalization.attachFilesAndPictures,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  context.appLocalization.attachPdfOrImages,
                                  style: TextStyle(
                                    color: context.colorPalette.grey66,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (files.isNotEmpty)
                            Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: context.colorPalette.green008,
                                borderRadius: BorderRadius.circular(
                                    MyTheme.radiusSecondary),
                              ),
                              child: Text("${files.length}"),
                            ),
                        ],
                      ),
                    ),
                  ),
                  StretchedButton(
                    onPressed: () {},
                    child: Text(
                      context.appLocalization.send,
                      style: TextStyle(
                        color: context.colorPalette.black33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
