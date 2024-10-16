

import 'dart:developer';
import 'package:gsheets/gsheets.dart';
import 'package:nubcc/google_sheet_init.dart';
import 'package:nubcc/module/teacher/model/teacher_model.dart';


class TeacherDataLink {
  static Worksheet? _teacherSheet;

  static List<TeacherModel> teachersList = [];

  static const int _pageSize = 10;
  static int _currentPage = 0;
  static bool _hasMoreData = true;

  static Future<bool> initAndFetchData() async {
    if (!_hasMoreData) return false;
    try {
      final spreadSheet = await GoogleSheetInit().inti();
      _teacherSheet = await _getWorkSheet(spreadSheet, sheetName: 'Teacher');
      if (_teacherSheet != null) {
        final rows = await _teacherSheet!.values.allRows();
        final startRow = _currentPage * _pageSize + 1;
        final pageRows = rows.skip(startRow).take(_pageSize).toList();

        if (pageRows.isNotEmpty) {
          for (var row in pageRows) {
            final teacherMap = {
              'Id': row[0],
              'Name': row[1],
              'University': row[2],
              'Contact': row[3],
              'Email': row[4],
              'LinkedIn': row[5],
              'Title': row[6],
            };
            teachersList.add(TeacherModel.fromJson(teacherMap));
          }

          log("Data fetched successfully. Total students: ${teachersList.length}");
          _currentPage++;

          if (pageRows.length < _pageSize) {
            _hasMoreData = false;
          }
        } else {
          _hasMoreData = false; // No more data found
          log("No more data available.");
        }
      }
      else {
        log("Teacher worksheet not found.");
      }
      return true;
    } catch (exception) {
      log("Error fetching teacher data: $exception");
      return true;
    }
  }

  static Future<Worksheet?> _getWorkSheet(Spreadsheet spreadsheet, {required String sheetName}) async {
    return spreadsheet.worksheetByTitle(sheetName);
  }
}
