
import 'dart:developer';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:nubcc/google_sheet_init.dart';
import 'package:nubcc/main.dart';
import 'package:nubcc/module/UserInfo/model/user_info_model.dart';
import 'package:nubcc/module/buttom_navigator/buttom_navigator_view.dart';

class UserInfoDataLink{


  static Worksheet? _userInfoSheet;

  static Future inti() async{
    try{
      final spreadSheet = await GoogleSheetInit().inti();
      _userInfoSheet = await _getWorkSheet(spreadSheet,sheetName:'UserInfo');
      final firstRow = UserInfoModel.getUserInfo();
      _userInfoSheet!.values.insertRow(1, firstRow);
    }
    catch(exception){
      log("Init error UserInfoDataLink: $exception");
    }
  }

  static Future<bool> insert(List<Map<String,dynamic>> rowList) async{
    if(_userInfoSheet == null){
      SmartDialog.dismiss();
      return false;
    }
    _userInfoSheet!.values.map.appendRows(rowList);
    SmartDialog.dismiss();
    preferences.setInt('initScreen',1);
    Get.offAll(const BottomNavigationWidget());
    return true;
  }

  static _getWorkSheet(Spreadsheet spreadSheet, {required String sheetName}) async{
    try{
      return await spreadSheet.addWorksheet(sheetName);
    }
    catch (exception){
      return spreadSheet.worksheetByTitle(sheetName);
    }
  }
}