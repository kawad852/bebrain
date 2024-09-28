import 'package:bebrain/model/teacher_model.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TeacherTime extends StatelessWidget {
  final List<InterviewDay> interviewDays;
  const TeacherTime({super.key, required this.interviewDays});

  String _timeFormat(DateTime time) {
    return DateFormat("hh:mma").format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(0.5),
        1: FlexColumnWidth(0.5),
      },
      border: TableBorder(
        borderRadius: BorderRadius.circular(10),
        horizontalInside: BorderSide(
          color: context.colorPalette.black33,
        ),
        verticalInside: BorderSide(
          color: context.colorPalette.black33,
        ),
        top: BorderSide(
          color: context.colorPalette.black33,
        ),
        bottom: BorderSide(
          color: context.colorPalette.black33,
        ),
        left: BorderSide(
          color: context.colorPalette.black33,
        ),
        right: BorderSide(
          color: context.colorPalette.black33,
        ),
      ),
      children: [
        TableRow(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  context.appLocalization.day,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  context.appLocalization.theHour,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        ...interviewDays.map((element) {
          return TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Center(
                  child: Text(element.day!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _timeFormat(element.from!),
                    ),
                    const Text("  ---  "),
                    Text(
                      _timeFormat(element.to!),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList()
      ],
    );
  }
}
