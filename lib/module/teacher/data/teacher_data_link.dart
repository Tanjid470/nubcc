

import 'dart:developer';
import 'package:gsheets/gsheets.dart';
import 'package:nubcc/google_sheet_init.dart';
import 'package:nubcc/module/teacher/model/teacher_model.dart';


class TeacherDataLink {
  static Worksheet? _teacherSheet;

  static List<TeacherModel> teachersList = [];

  static Future<void> initAndFetchData() async {
    teachersList.clear();
    try {
      final spreadSheet = await GoogleSheetInit().inti();
      _teacherSheet = await _getWorkSheet(spreadSheet, sheetName: 'Teacher');

      if (_teacherSheet != null) {
        final rows = await _teacherSheet!.values.allRows();
        for (var i = 1; i < rows.length; i++) {
          final studentMap = {
            'Id': rows[i][0], // First column: Id
            'Name': rows[i][1], // Second column: Name
            'University': rows[i][2], // Third column: University
          };
          teachersList.add(TeacherModel.fromMap(studentMap));
        }
        log("Data fetched successfully. Total students: ${teachersList.length}");
      } else {
        log("Student worksheet not found.");
      }
    } catch (exception) {
      log("Error fetching student data: $exception");
    }
  }

  // Helper method to get the Worksheet (implement this based on your Google Sheets setup)
  static Future<Worksheet?> _getWorkSheet(Spreadsheet spreadsheet, {required String sheetName}) async {
    return spreadsheet.worksheetByTitle(sheetName);
  }
}
