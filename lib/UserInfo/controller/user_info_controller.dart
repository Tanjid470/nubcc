
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class UserInfoController extends GetxController{
  TextEditingController whatsappNumberController = TextEditingController();
  int? selectedValueCategory;
  int? selectedValueDepartment;
  int? selectedValueSemester;
  int? selectedValueSession;

  @override
  void onInit() async{

    super.onInit();
  }


  TextEditingController nameController = TextEditingController();
  RxString userNameErrorMassage = ''.obs;
  RxBool inputValidUserName = false.obs;
  userNameInputValidation(){
    if(nameController.text.isEmpty){
      userNameErrorMassage('আপনার নাম লিখুন');
      inputValidUserName.value = false;
    }
    else{
      userNameErrorMassage.value = '';
      inputValidUserName.value = true;
    }
    update();
  }

  TextEditingController emailController = TextEditingController();
  RxString userEmailErrorMassage = ''.obs;
  RxBool inputValidUserEmail = false.obs;

  userEmailInputValidation(){
    bool emailValid = RegExp(
        r"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
    ).hasMatch(emailController.text);

    if(emailController.text.isEmpty){
      userEmailErrorMassage('আপনার ইমেইল লিখুন');
      inputValidUserEmail.value = false;
    }
    else if(emailValid != true){
      userEmailErrorMassage('আপনার ইমেইল সঠিক নয়');
      inputValidUserEmail.value = false;
    }
    else{
      userEmailErrorMassage.value = '';
      inputValidUserEmail.value = true;
    }

    update();
  }

  RxString phoneNumberErrorMassage = ''.obs;
  RxBool inputValidNumber = false.obs;

  RxBool saveButtonEnableFlag =false.obs;


  void saveButtonEnable(){
    if( selectedValueCategory != null
        && selectedValueDepartment != null
        && selectedValueSemester != null
        && emailController.text.isNotEmpty
        && nameController.text.isNotEmpty){
      saveButtonEnableFlag.value = true;
    }
    else{
      saveButtonEnableFlag.value = false;
    }
  }

  numberInputValidation(){
    RegExp regExp = RegExp(r'(^(?:\+?88|0088)?01[3-9]\d{8}$)');
    if(whatsappNumberController.text.isEmpty){
      phoneNumberErrorMassage('আপনার মোবাইল নাম্বার দিন');
      inputValidNumber.value = false;
    }
    else if(whatsappNumberController.text.length > 1 && whatsappNumberController.text.length < 11){
      phoneNumberErrorMassage('ফোন নাম্বার ১১ ডিজিটের হতে হবে');
      inputValidNumber.value = false;
    }
    else if(!regExp.hasMatch(whatsappNumberController.text)){
      phoneNumberErrorMassage.value = 'সঠিক মোবাইল নম্বর দিন';
      inputValidNumber.value = false;
    }
    else{
      phoneNumberErrorMassage.value = '';
      inputValidNumber.value = true;
    }
    update();
  }




}