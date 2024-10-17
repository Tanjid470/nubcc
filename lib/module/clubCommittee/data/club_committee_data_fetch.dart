import 'dart:developer';
import 'package:gsheets/gsheets.dart';
import 'package:nubcc/google_sheet_init.dart';
import 'package:nubcc/module/clubCommittee/model/club_committee_model.dart';



class ClubCommitteeDataFetch {
  static Worksheet? _clubCommitteeSheet;

  static List<ClubCommitteeModel> clubCommitteeList = [];

  static const int _pageSize = 10;
  static int _currentPage = 0;
  static bool _hasMoreData = true;

  static Future<bool> initAndFetchData() async {
    if (!_hasMoreData) return false;
    try {
      final spreadSheet = await GoogleSheetInit().inti();
      _clubCommitteeSheet = await _getWorkSheet(spreadSheet, sheetName: 'ClubCommittee');
      if (_clubCommitteeSheet != null) {
        final rows = await _clubCommitteeSheet!.values.allRows();
        final startRow = _currentPage * _pageSize + 1;
        final pageRows = rows.skip(startRow).take(_pageSize).toList();

        if (pageRows.isNotEmpty) {
          for (var row in pageRows) {
            final clubCommitteeMap = {
              'Name': row[0],
              'Contact': row[1],
              'Email': row[2],
              'Semester': row[3],
              'Section': row[4],
              'Id': row[5],
              'Image': row[6],
              'Blood': row[7],
              'Hometown': row[8],
              'Role': row[9],
            };
            log(clubCommitteeMap.toString());
            clubCommitteeList.add(ClubCommitteeModel.fromJson(clubCommitteeMap));
          }
          log("Data fetched successfully. Total clubCommitteeMap: ${clubCommitteeList.length}");
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
