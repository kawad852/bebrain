import 'dart:io';

import 'package:bebrain/model/wizard_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/network/api_url.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/send_request/widgets/request_menu.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
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
  late MainProvider _mainProvider;
  late Future<WizardModel> _wizardFuture;

  FilePickerResult? result;
  List<File> files = [];

  List<WizardData> _universities = [];
  List<WizardData> _colleges = [];
  List<WizardData> _majors = [];

  int? countryId;
  int? universityId;
  int? collegeId;
  int? majorId;

  late String countryHintText = context.appLocalization.selectCountry;
  late String universityHintText = context.appLocalization.selectUniversity;
  late String collegeHintText = context.appLocalization.selectCollege;
  late String majorHintText = context.appLocalization.selectSpecialization;

  void _initializeFuture() async {
    _wizardFuture = _mainProvider.fetchCUCM(ApiUrl.countries);
  }

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
    _initializeFuture();
  }


  void _fetchData(String url, String wizardType) {
    ApiFutureBuilder<WizardModel>().fetch(
      context,
      future: () async {
        final verifyCode = _mainProvider.fetchCUCM(url);
        return verifyCode;
      },
      onComplete: (snapshot) {
        final data = snapshot.data!;
        setState(
          () {
            switch (wizardType) {
              case WizardType.universities:
                _universities = data;
              case WizardType.colleges:
                _colleges = data;
              case WizardType.specialities:
                _majors = data;
            }
          },
        );
      },
    );
  }

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
    return CustomFutureBuilder(
      future: _wizardFuture,
      withBackgroundColor: true,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onComplete: (context, snapshot) {
        final countries = snapshot.data!;
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
                        title: "${context.appLocalization.country} *",
                        child: RequestMenu(
                          hintText: countryHintText,
                          wizardData: countries.data!,
                          onSelected: (value) {
                            var entryList = value!.entries.toList();
                            _fetchData('${ApiUrl.universities}/${entryList[0].value}', WizardType.universities);
                            setState(() {
                              countryId = entryList[0].value;
                              countryHintText = entryList[0].key;
                              universityHintText = context.appLocalization.selectUniversity;
                              collegeHintText = context.appLocalization.selectCollege;
                              majorHintText = context.appLocalization.selectSpecialization;
                              universityId=null;
                              collegeId=null;
                              majorId=null;
                              _colleges = [];
                              _majors = [];
                            });
                          },
                        ),
                      ),
                      TitledTextField(
                        title: "${context.appLocalization.university} *",
                        child: RequestMenu(
                          hintText: universityHintText,
                          wizardData: _universities,
                          onSelected: (value) {
                            var entryList = value!.entries.toList();
                            _fetchData('${ApiUrl.colleges}/${entryList[0].value}', WizardType.colleges);
                            setState(() {
                              universityId = entryList[0].value;
                              universityHintText = entryList[0].key;
                              collegeHintText = context.appLocalization.selectCollege;
                              majorHintText = context.appLocalization.selectSpecialization;
                              collegeId=null;
                              majorId=null;
                              _majors = [];
                            });
                          },
                        ),
                      ),
                      TitledTextField(
                        title: "${context.appLocalization.college} *",
                        child: RequestMenu(
                          hintText: collegeHintText,
                          wizardData: _colleges,
                          onSelected: (value) {
                            var entryList = value!.entries.toList();
                            _fetchData('${ApiUrl.specialties}/${entryList[0].value}', WizardType.specialities);
                            setState(() {
                              collegeId = entryList[0].value;
                              collegeHintText = entryList[0].key;
                              majorHintText =context.appLocalization.selectSpecialization;
                              majorId=null;
                            });
                          },
                        ),
                      ),
                      TitledTextField(
                        title: "${context.appLocalization.specialization} *",
                        child: RequestMenu(
                          hintText: majorHintText,
                          wizardData: _majors,
                          onSelected: (value) {
                            var entryList = value!.entries.toList();
                            setState(() {
                              majorId = entryList[0].value;
                              majorHintText = entryList[0].key;
                            });
                          },
                        ),
                      ),
                      TitledTextField(
                        title: "${context.appLocalization.title} *",
                        child: BaseEditor(
                          hintText:context.appLocalization.titleOfReportOrResarch,
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
                                      "${context.appLocalization.attachFilesAndPictures} *",
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
                                    borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
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
      },
    );
  }
}
