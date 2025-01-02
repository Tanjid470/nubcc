import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:nubcc/google_sheet_init.dart';
import 'package:nubcc/main.dart';
import 'package:nubcc/module/UserInfo/model/user_info_model.dart';
import 'package:nubcc/module/buttom_navigator/buttom_navigator_view.dart';

class LoginController extends GetxController{
  TextEditingController emailController = TextEditingController();

  RxBool saveButtonEnableFlag =false.obs;

  void saveButtonEnable(){
    if(emailController.text.isNotEmpty){
      saveButtonEnableFlag.value = true;
    }
    else{
      saveButtonEnableFlag.value = false;
    }
  }

  static Worksheet? _userInfoSheet;

  @override
  void onInit() {
    inti();
    super.onInit();
  }

  static Future inti() async{
    try{
      final spreadSheet = await GoogleSheetInit().inti();
      _userInfoSheet = await _getWorkSheet(spreadSheet,sheetName:'UserInfo');
    }
    catch(exception){
      log("Init error UserInfoDataLink: $exception");
    }
  }

  static _getWorkSheet(Spreadsheet spreadSheet, {required String sheetName}) async{
    try{
      return await spreadSheet.addWorksheet(sheetName);
    }
    catch (exception){
      return spreadSheet.worksheetByTitle(sheetName);
    }
  }

   Future<bool> login(String email) async {
    if (_userInfoSheet == null) {
      SmartDialog.dismiss();
      return false;
    }

    try {

      final allRows = await _userInfoSheet!.values.allRows();

      final headerRow = allRows.first;
      final emailIndex = headerRow.indexOf('email');

      if (emailIndex == -1) {
        log("Login error: 'email' column not found in sheet.");
        SmartDialog.dismiss();
        return false;
      }
      for (var row in allRows.skip(1)) {
        if (row[emailIndex] == email) {
          log("Login successful for email: ${row[emailIndex]}");
          SmartDialog.dismiss();
          preferences.setInt('initScreen', 1);
          Get.offAll(const BottomNavigationWidget());
          return true;
        }
      }

      // If no match found
      log("Login failed: Email not found.");
      SmartDialog.dismiss();
      return false;
    } catch (e) {
      log("Login error: $e");
      SmartDialog.dismiss();
      return false;
    }
  }

}