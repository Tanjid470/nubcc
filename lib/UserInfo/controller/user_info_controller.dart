
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class UserInfoController extends GetxController{

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController studentIdController =TextEditingController();
  int? semesterID;
  int? bloodGroup;


  @override
  void onInit() async{

    super.onInit();
  }



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



  RxBool saveButtonEnableFlag =false.obs;


  void saveButtonEnable(){
    if( semesterID != null
        && studentIdController.text.isNotEmpty
        && emailController.text.isNotEmpty
        && nameController.text.isNotEmpty
        && phoneController.text.isNotEmpty
    ){
      saveButtonEnableFlag.value = true;
    }
    else{
      saveButtonEnableFlag.value = false;
    }
  }


  RxString phoneNumberErrorMassage = ''.obs;
  RxBool inputValidNumber = false.obs;

  numberInputValidation(){
    RegExp regExp = RegExp(r'(^(?:\+?88|0088)?01[3-9]\d{8}$)');
    if(phoneController.text.isEmpty){
      phoneNumberErrorMassage('আপনার মোবাইল নাম্বার দিন');
      inputValidNumber.value = false;
    }
    else if(phoneController.text.length > 1 && phoneController.text.length < 11){
      phoneNumberErrorMassage('ফোন নাম্বার ১১ ডিজিটের হতে হবে');
      inputValidNumber.value = false;
    }
    else if(!regExp.hasMatch(phoneController.text)){
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