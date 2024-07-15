import 'dart:io';

import 'package:bebrain/helper/ui_helper.dart';
import 'package:bebrain/model/teacher_model.dart';
import 'package:bebrain/screens/teacher/widgets/date_bubble.dart';
import 'package:bebrain/screens/teacher/widgets/subject_menu.dart';
import 'package:bebrain/screens/teacher/widgets/teacher_info.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/editors/base_editor.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:bebrain/widgets/titled_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class BookingLectureScreen extends StatefulWidget {
  final TeacherData teacherData;
  const BookingLectureScreen({super.key, required this.teacherData});

  @override
  State<BookingLectureScreen> createState() => _BookingLectureScreenState();
}

class _BookingLectureScreenState extends State<BookingLectureScreen> {
  TeacherData get _teacher => widget.teacherData;

  late String subjectHintText = context.appLocalization.selectSubject;
  late String dateHintText = context.appLocalization.suggestedDate;
  late String hourHintText = context.appLocalization.suggestedHour;
  late DateTime _selectedDate;
  late TimeOfDay _selectedHour;
  int? _subjectId;
  String? _hoursNumber;
  String? _title;
  String? _notes;

  FilePickerResult? result;
  List<File> files = [];

  void _selectFiles(FileType type) async {
    context.pop();
    result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: type,
      allowedExtensions: type == FileType.image ? null : ['jpg', 'pdf', 'jpeg', 'png'],
    );
    if (result != null) {
      files = result!.paths.map((path) => File(path!)).toList();
      setState(() {});
    }
  }
 List<int> days =[2,3,4,5,6,];
  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      //initialDate: _selectedDate.add(Duration(days: 1)),
      selectableDayPredicate: (DateTime day) => 
        days.contains(day.weekday),
      
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        dateHintText = _selectedDate.formatDate(context);
      });
    }
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedHour,
    );
    if (picked != null) {
      setState(() {
        _selectedHour = picked;
        if (context.mounted) {
          hourHintText = picked.format(context);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedHour = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: StretchedButton(
          onPressed: (){},
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(context.appLocalization.send),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            collapsedHeight: 170,
            flexibleSpace: Container(
              color: context.colorPalette.blueC2E,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: 50),
                child: TeacherInfo(teacher: _teacher),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.appLocalization.toBookLectureWithProfessor,
                    style: TextStyle(
                      color: context.colorPalette.grey66,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TitledTextField(
                    title: "${context.appLocalization.subject} *",
                    child: SubjectMenu(
                      hintText: subjectHintText,
                      subjects: _teacher.subjects!,
                      onSelected: (value) {
                        var entryList = value!.entries.toList();
                        setState(() {
                          subjectHintText = entryList[0].key;
                          _subjectId = entryList[0].value;
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
                  Row(
                    children: [
                      Expanded(
                        child: TitledTextField(
                          title: "${context.appLocalization.date} *",
                          child: DateBubble(
                            hintText: dateHintText,
                            onTap: () {
                              _showDatePicker(context);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TitledTextField(
                          title: "${context.appLocalization.theHour} *",
                          child: DateBubble(
                            hintText: hourHintText,
                            onTap: () {
                              _showTimePicker(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: context.mediaQuery.width * 0.46,
                    child: TitledTextField(
                      title: "${context.appLocalization.hoursRequired} *",
                      child: BaseEditor(
                        hintText: context.appLocalization.hoursToBeReserved,
                        keyboardType: TextInputType.number,
                        initialValue: null,
                        onChanged: (value) => _hoursNumber = value.isEmpty ? null : value,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () {
                        UiHelper.selectFileDialog(
                          context,
                          onTapFiles: () {
                            _selectFiles(FileType.custom);
                          },
                          onTapGallery: () {
                            _selectFiles(FileType.image);
                          },
                        );
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
