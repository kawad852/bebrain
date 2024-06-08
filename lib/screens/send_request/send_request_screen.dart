import 'dart:io';

import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/model/new_request_model.dart';
import 'package:bebrain/model/wizard_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/network/api_url.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/request/request_screen.dart';
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
  final String formEnum;
  const SendRequestScreen({super.key, required this.formEnum});

  @override
  State<SendRequestScreen> createState() => _SendRequestScreenState();
}

class _SendRequestScreenState extends State<SendRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  late Future<List<dynamic>> _futures;
  late MainProvider _mainProvider;
  late Future<WizardModel> _countryFuture;
  late Future<WizardModel> _universityFuture;
  late Future<WizardModel> _collegeFuture;
  late Future<WizardModel> _majorFuture;

  FilePickerResult? result;
  List<File> files = [];

  List<WizardData> _countries = [];
  List<WizardData> _universities = [];
  List<WizardData> _colleges = [];
  List<WizardData> _majors = [];

  late int? countryId = context.authProvider.wizardValues.countryId;
  late int? universityId = context.authProvider.wizardValues.universityId;
  late int? collegeId = context.authProvider.wizardValues.collegeId;
  late int? majorId = context.authProvider.wizardValues.majorId;

  late String countryHintText = context.authProvider.wizardValues.countryName ?? context.appLocalization.selectCountry;
  late String universityHintText = context.authProvider.wizardValues.universityName ?? context.appLocalization.selectUniversity;
  late String collegeHintText = context.authProvider.wizardValues.collegeName ?? context.appLocalization.selectCollege;
  late String majorHintText = context.authProvider.wizardValues.majorName ?? context.appLocalization.selectSpecialization;

  String? _title;
  String? _notes;

  Future<List<dynamic>> _initializeFutures() async {
    _countryFuture = _mainProvider.fetchCUCM(ApiUrl.countries);
    final countries = await _countryFuture;
    _countries = countries.data!;
    if (mounted) {
      if (context.authProvider.wizardValues.countryId != null) {
        _universityFuture = _mainProvider.fetchCUCM('${ApiUrl.universities}/${context.authProvider.wizardValues.countryId}');
        final universities = await _universityFuture;
        _universities = universities.data!;

        if (mounted && context.authProvider.wizardValues.universityId != null) {
          _collegeFuture = _mainProvider.fetchCUCM('${ApiUrl.colleges}/${context.authProvider.wizardValues.universityId}');
          final colleges = await _collegeFuture;
          _colleges = colleges.data!;

          if (mounted && context.authProvider.wizardValues.collegeId != null) {
            _majorFuture = _mainProvider.fetchCUCM('${ApiUrl.specialties}/${context.authProvider.wizardValues.collegeId}');
            final majors = await _majorFuture;
            _majors = majors.data!;
          }
        }
      }
    }
    return Future.wait([]);
  }

  void _sendRequest() {
    if (countryId == null || universityId == null || collegeId == null || majorId == null || _title == null || files.isEmpty) {
      context.showSnackBar(context.appLocalization.fillAllFields);
    } else {
      ApiFutureBuilder<NewRequestModel>().fetch(context, future: () async {
        final createRequest = _mainProvider.createRequest(
          type: widget.formEnum,
          countryId: countryId!,
          universityId: universityId!,
          collegeId: collegeId!,
          majorId: majorId!,
          title: _title!,
          note: _notes,
          attachments: files,
        );
        return createRequest;
      }, onComplete: (snapshot) {
        context.pop();
        context.push(RequestScreen(requestId: snapshot.data!.id!));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
    _futures = _initializeFutures();
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
      allowedExtensions: ['jpg', 'pdf','jpeg','png'],
    );
    if (result != null) {
      files = result!.paths.map((path) => File(path!)).toList();
      setState(() {});
    }
  }

  String descriptipnPage() {
    switch (widget.formEnum) {
      case FormEnum.assignment:
        return context.appLocalization.requestSolveAssignmentAndSendRequest;
      case FormEnum.studyExplanation:
        return context.appLocalization.requestExplainArtical;
      case FormEnum.project:
        return context.appLocalization.requestGraduationProject;
      default:
        throw 'Form Not Defined';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _futures,
      withBackgroundColor: true,
      onRetry: () {
        setState(() {
          _futures = _initializeFutures();
        });
      },
      onComplete: (context, snapshot) {
        return Form(
          key: _formKey,
          child: Scaffold(
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
                            wizardData: _countries,
                            onSelected: (value) {
                              var entryList = value!.entries.toList();
                              _fetchData('${ApiUrl.universities}/${entryList[0].value}', WizardType.universities);
                              setState(() {
                                countryId = entryList[0].value;
                                countryHintText = entryList[0].key;
                                universityHintText = context.appLocalization.selectUniversity;
                                collegeHintText = context.appLocalization.selectCollege;
                                majorHintText = context.appLocalization.selectSpecialization;
                                universityId = null;
                                collegeId = null;
                                majorId = null;
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
                                collegeId = null;
                                majorId = null;
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
                                majorHintText = context.appLocalization.selectSpecialization;
                                majorId = null;
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
                            hintText: context.appLocalization.titleOfReportOrResarch,
                            initialValue: null,
                            onChanged: (value) => _title = value.isEmpty ? null : value,
                          ),
                        ),
                        TitledTextField(
                          title: context.appLocalization.notes,
                          child: BaseEditor(
                            hintText: context.appLocalization.descriptionAboutAssignment,
                            maxLines: 4,
                            initialValue: null,
                            onChanged: (value) => _notes = value.isEmpty ? null : value,
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
                                    crossAxisAlignment:CrossAxisAlignment.start,
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
                          onPressed: () {
                            _sendRequest();
                          },
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
          ),
        );
      },
    );
  }
}
