import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:nubcc/config/responsive_scale.dart';
import 'package:nubcc/const/app_colors.dart';
import 'package:nubcc/const/font_constant.dart';
import 'package:nubcc/module/UserInfo/controller/userInfo_data_link.dart';
import 'package:nubcc/module/UserInfo/controller/user_info_controller.dart';
import 'package:nubcc/module/UserInfo/model/user_info_model.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});
  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  UserInfoController userInfoController = Get.put(UserInfoController());


  Map<int, String> semester = {1: '1st semester', 2: '2nd semester'};

  List<DropdownMenuItem<int>> semesterItems() {
    List<DropdownMenuItem<int>> semestersItems = [];
    for (var key in semester.keys) {
      var semesterEntry = semester[key];
      semestersItems.add(
        DropdownMenuItem<int>(
          value: key,
          child: Text(
            "⋄ $semesterEntry",
            style: TextStyle(
              fontSize: TextSize.font14(context),
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
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(height: ResponsiveScale.of(context).hp(5)),
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back_ios_new)),
                 Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          'Welcome to',
                          style: TextStyle(
                              fontSize: TextSize.font24(context),
                              fontFamily: 'HindSiliguri',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' NUBCC',
                          style: TextStyle(
                              fontSize: TextSize.font24(context),
                              color: AppColor.baseColor,
                              fontFamily: 'HindSiliguri',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Center(
              child: Text(
                'Explore your learning and skills',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'HindSiliguri',
                    color: Colors.black45),
              ),
            ),
            allDataInputField(),
          ],
        ),
      ),
      floatingActionButton: SafeArea(child: saveButton()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget allDataInputField() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: const Color(0xffFFF5EC),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: const Color(0xffF59E0B).withOpacity(.5))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.info_outline, color: Color(0xffF59E0B)),
                ),
                Text(
                  'Can\'t be change ',
                  style: TextStyle(
                      color: const Color(0xffF59E0B),
                      fontSize: TextSize.font14(context),
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          inputHeader(context, 'Name'),
          // customTextField(userInfoController.nameController,
          //     "Enter your name", Icons.drive_file_rename_outline),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: userInfoController.nameController.text.isEmpty
                      ? Colors.grey.shade500
                      : const Color(0xff0346ae),
                )),
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
                  color: userInfoController.nameController.text.isEmpty
                      ? Colors.grey.shade400
                      : AppColor.baseColor,
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
          Obx(
            () => userInfoController.userNameErrorMassage.value.isNotEmpty
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: Text(userInfoController.userNameErrorMassage.value,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: TextSize.font14(context),
                            // fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400)),
                  )
                : const SizedBox.shrink(),
          ),
          inputHeader(context, 'Email'),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: userInfoController.emailController.text.isEmpty
                      ? Colors.grey.shade500
                      : const Color(0xff0346ae),
                )),
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
                  color: userInfoController.emailController.text.isEmpty
                      ? Colors.grey.shade400
                      : AppColor.baseColor,
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
          Obx(
            () => userInfoController.userEmailErrorMassage.value.isNotEmpty
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: Text(userInfoController.userEmailErrorMassage.value,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: TextSize.font14(context),
                            fontWeight: FontWeight.w400)),
                  )
                : const SizedBox.shrink(),
          ),
          inputHeader(context, 'Number'),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 5), // Adjust vertical padding here
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: userInfoController.phoneController.text.isEmpty
                    ? Colors.grey.shade500
                    : const Color(0xff0346ae),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 10), // Adjust side padding
                Text(
                  '+88',
                  style: TextStyle(
                    fontSize: TextSize.font16(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' | ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: TextSize.font16(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: userInfoController.phoneController,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                      fontSize: TextSize.font16(context),
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    decoration: InputDecoration(
                      counterText: "",
                      isDense: true, // Minimize vertical padding within TextField
                      contentPadding: const EdgeInsets.symmetric(vertical: 6), // Adjust field padding
                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "01XXX - XXXXXX",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: TextSize.font16(context),
                      ),
                    ),
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

          Obx(
            () => userInfoController.phoneNumberErrorMassage.value.isNotEmpty
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: Text(
                        userInfoController.phoneNumberErrorMassage.value,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: TextSize.font14(context),
                            fontWeight: FontWeight.w400)),
                  )
                : const SizedBox.shrink(),
          ),
          inputHeader(context, 'Semester'),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: userInfoController.semesterID == null
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
                hint: Text(
                  'Select Semester',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                isExpanded: true,
                value: userInfoController.semesterID,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: TextSize.font14(context) * 2,
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
              )),
          inputHeader(context, 'Student ID'),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: userInfoController.studentIdController.text.isEmpty
                      ? Colors.grey.shade500
                      : const Color(0xff0346ae),
                )),
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
                  color: userInfoController.studentIdController.text.isEmpty
                      ? Colors.grey.shade400
                      : AppColor.baseColor,
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
          inputHeader(context, 'Blood Group'),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
                hint: Text('Select',
                    style: TextStyle(color: Colors.grey.shade500)),
                isExpanded: true,
                value: userInfoController.bloodGroup,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: TextSize.font14(context)* 2,
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
              )),
        ],
      ),
    );
  }

  Widget saveButton() {
    return userInfoController.saveButtonEnableFlag.value
        ? InkWell(
            onTap: () async {
              userInfoController.userEmailInputValidation();
              userInfoController.numberInputValidation();
              if (userInfoController.inputValidNumber.value &&
                  userInfoController.inputValidUserEmail.value) {
                SmartDialog.showLoading();
                await UserInfoDataLink.inti();
                final userInfoInsert = {
                  UserInfoModel.name: userInfoController.nameController.text,
                  UserInfoModel.email: userInfoController.emailController.text,
                  UserInfoModel.number: userInfoController.phoneController.text,
                  UserInfoModel.semester: userInfoController.semesterID,
                  UserInfoModel.studentId:
                      userInfoController.studentIdController.text,
                  UserInfoModel.bloodGroup: 'B+',
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
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black, // Shadow color
                      spreadRadius: 1,
                      offset: Offset(1, 2),
                    )
                  ]),
              child:  Text(
                'Save',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'HindSiliguri',
                  fontSize: TextSize.font16(context),
                  fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : InkWell(
            onTap: () => SmartDialog.showToast('fill up all required field'),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black, // Shadow color
                      spreadRadius: 1,
                      offset: Offset(1, 2),
                    ),]
              ),
              child: Text(
                'Save',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'HindSiliguri',
                  fontSize: TextSize.font16(context),
                    fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
  }

  Padding inputHeader(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: TextSize.font14(context),
          fontWeight: FontWeight.w600,
          color: const Color(0xff5E6579),
        ),
      ),
    );
  }

  Container customTextField(TextEditingController controller, String hintText, IconData icon) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: controller.text.isEmpty
                ? Colors.grey.shade400
                : AppColor.baseColor,
          )),
      child: TextField(
        controller: controller,
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
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: controller.text.isEmpty
                ?Colors.grey.shade400
                : Colors.blueAccent,
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
    );
  }
}
