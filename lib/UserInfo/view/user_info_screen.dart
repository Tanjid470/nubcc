
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:nubcc/UserInfo/controller/userInfo_data_link.dart';
import 'package:nubcc/UserInfo/controller/user_info_controller.dart';
import 'package:nubcc/UserInfo/model/user_info_model.dart';


class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  UserInfoController userInfoController = Get.put(UserInfoController());
  double textSize = 14;

  Map<int, String> semester = {
    1: '1st semester',
    2: '2nd semester'
  };

  List<DropdownMenuItem<int>> semesterItems() {
    List<DropdownMenuItem<int>> semestersItems = [];
    for (var key in semester.keys) {
      var semesterEntry = semester[key];
      semestersItems.add(
        DropdownMenuItem<int>(
          value: key,
          child: Text("⋄ $semesterEntry",
            style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
    return semestersItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 15.0),
        child: allDataInputField(),
      ),
      floatingActionButton: SafeArea(child: saveButton()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget allDataInputField(){
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: const BoxDecoration(
              color: Color(0xffFFF5EC),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.center ,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.info_outline, color: Color(0xffF59E0B)),
                )
                ,Text('Can\'t be change ',
                  style: TextStyle(
                      color: const Color(0xffF59E0B),
                      fontSize: textSize,
                      fontWeight: FontWeight.w400
                  ),)
              ],
            ),
          ),
          inputHeader(context,'Name'),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: userInfoController.nameController.text.isEmpty
                    ? Colors.grey.shade500
                    : const Color(0xff0346ae),
                )
            ),
            child: TextField(
              controller: userInfoController.nameController,
              textInputAction: TextInputAction.next,
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'HindSiliguri',
                  // color: HexColor('#7A7A7A'),
                  fontWeight: FontWeight.bold),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: "Enter your name",
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.grey.shade400,
                ),
                hintStyle: TextStyle(
                    fontFamily: 'HindSiliguri',
                    color: Colors.grey.shade400,
                    fontSize: 16),
                //hintStyle: const TextStyle(color: Colors.orangeAccent),
              ),
              onChanged: (value) {
                userInfoController.saveButtonEnable();
                setState(() {});
              },
            ),
          ),
          Obx(() => userInfoController.userNameErrorMassage.value.isNotEmpty
              ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
            child: Text(
                userInfoController.userNameErrorMassage.value,
                style:  TextStyle(
                    color: Colors.red,
                    fontSize: textSize,
                    // fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400)),
          )
              : const SizedBox.shrink(),),

          inputHeader(context,'Email'),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: userInfoController.emailController.text.isEmpty
                    ? Colors.grey.shade500
                    : const Color(0xff0346ae),
                )
            ),
            child: TextField(
              controller: userInfoController.emailController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'HindSiliguri',
                  // color: HexColor('#7A7A7A'),
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: "example123@gmail.com ",
                prefixIcon: Icon(
                  Icons.mail_outline,
                  color: Colors.grey.shade400,
                ),
                hintStyle: TextStyle(
                    fontFamily: 'HindSiliguri',
                    color: Colors.grey.shade400,
                    fontSize: 16),
              ),
              onChanged: (value) {
                userInfoController.saveButtonEnable();
                setState(() {});
              },
            ),
          ),
          Obx(() => userInfoController.userEmailErrorMassage.value.isNotEmpty
              ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
            child: Text(
                userInfoController.userEmailErrorMassage.value,
                style:  TextStyle(
                    color: Colors.red,
                    fontSize: textSize,
                    fontWeight: FontWeight.w400)),
          )
              : const SizedBox.shrink(),),

          inputHeader(context,'Number'),
          Container(
            alignment: Alignment.center,
            decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: userInfoController.phoneController.text.isEmpty
                    ? Colors.grey.shade500
                    : const Color(0xff0346ae),
                )
            ),
            child: Row(
              children: [
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '  +88',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'HindSiliguri',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Text(' | ',
                    style: TextStyle(
                        color: Color(0xff0346ae),
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                Expanded(
                  child: TextField(
                    controller: userInfoController.phoneController,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                        fontSize: textSize,
                        fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    decoration: InputDecoration(
                        counterText: "",
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        hintText: "01XXX - XXXXXX",
                        hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontFamily: 'HindSiliguri',
                            fontSize: 16)),
                    onChanged: (value) {
                      userInfoController.phoneController.text = value;
                      userInfoController.saveButtonEnable();
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          Obx(() => userInfoController.phoneNumberErrorMassage.value.isNotEmpty
              ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                child: Text(
                    userInfoController.phoneNumberErrorMassage.value,
                    style:  TextStyle(
                        color: Colors.red,
                        fontSize: textSize,
                        fontWeight: FontWeight.w400)),
              )
              : const SizedBox.shrink(),),


          inputHeader(context,'Semester'),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: userInfoController.semesterID == null
                  ? Colors.grey.shade500
                  : const Color(0xff0346ae),
              ),
            ),
            child: DropdownButton<int>(
                dropdownColor: Colors.grey.shade100,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                autofocus: true,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                underline: const SizedBox(),
                hint:  Text('Select Semester',style: TextStyle(color: Colors.grey.shade500),),
                isExpanded: true,
                value: userInfoController.semesterID,
                icon:  Icon(Icons.keyboard_arrow_down,
                    size: textSize*2,
                    color: userInfoController.semesterID == null
                        ? Colors.grey.shade500
                        : const Color(0xff0346ae),
                ),
                onChanged: (int? newValue) async {
                  userInfoController.semesterID = newValue;
                  userInfoController.saveButtonEnable();
                  setState(() {});
                },
                items: semesterItems(),
              )
          ),

          inputHeader(context,'Student ID'),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: userInfoController.studentIdController.text.isEmpty
                    ? Colors.grey.shade500
                    : const Color(0xff0346ae),
                )
            ),
            child: TextField(
              controller: userInfoController.studentIdController,
              textInputAction: TextInputAction.next,
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'HindSiliguri',
                  // color: HexColor('#7A7A7A'),
                  fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: "Enter your student ID",
                prefixIcon: Icon(
                  Icons.code,
                  color: Colors.grey.shade400,
                ),
                hintStyle: TextStyle(
                    fontFamily: 'HindSiliguri',
                    color: Colors.grey.shade400,
                    fontSize: 16),
                //hintStyle: const TextStyle(color: Colors.orangeAccent),
              ),
              onChanged: (value) {
                userInfoController.saveButtonEnable();
                setState(() {});
              },
            ),
          ),


          inputHeader(context,'Blood Group'),
          Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: userInfoController.bloodGroup == null
                            ? Colors.grey.shade500
                            : const Color(0xff0346ae),
                      ),
                    ),
                    child: DropdownButton<int>(
                      dropdownColor: Colors.grey.shade100,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      autofocus: true,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      underline: const SizedBox(),
                      hint: Text('Select',style: TextStyle(color: Colors.grey.shade500)),
                      isExpanded: true,
                      value: userInfoController.bloodGroup,
                      icon:  Icon(Icons.keyboard_arrow_down,
                        size: textSize*2,
                        color: userInfoController.bloodGroup == null
                            ? Colors.grey.shade500
                            : const Color(0xff0346ae),
                      ),
                      onChanged: (int? newValue) {
                        userInfoController.bloodGroup = newValue;
                        userInfoController.saveButtonEnable();
                        setState(() {});
                      },
                      items: semesterItems(),
                    )
                ),
        ],
      ),
    );
  }

  Widget saveButton(){
    return userInfoController.saveButtonEnableFlag.value
        ? InkWell(
        onTap: () async{
          userInfoController.userEmailInputValidation();
          userInfoController.numberInputValidation();
          if(userInfoController.inputValidNumber.value && userInfoController.inputValidUserEmail.value){
              log("Action__________");
              await UserInfoDataLink.inti();
              SmartDialog.showLoading();
              final userInfoInsert = {
                UserInfoModel.name : userInfoController.nameController.text,
                UserInfoModel.email : userInfoController.emailController.text,
                UserInfoModel.number : userInfoController.phoneController.text,
                UserInfoModel.semester : userInfoController.semesterID,
                UserInfoModel.studentId : userInfoController.studentIdController.text,
                UserInfoModel.bloodGroup : 'B+',
              };
              await UserInfoDataLink.insert([userInfoInsert]);
          }
        },
        child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(colors: [
                    Color(0xff0346ae),
                    Color(0xff012351),
                  ]),
                  boxShadow:const [
                    BoxShadow(
                      color: Colors.black, // Shadow color
                      spreadRadius: 1,
                      offset: Offset(1, 2),
                    )
                  ]
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'HindSiliguri',
                    fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
        )
        : Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey
          ),
          child: Text(
            'Save',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'HindSiliguri',
                fontSize: textSize),
            textAlign: TextAlign.center,
          ),
        );
  }

  Padding inputHeader(BuildContext context,String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: textSize,
          fontWeight: FontWeight.w600,
          color: const Color(0xff5E6579),
        ),
      ),
    );
  }
}
