
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nubcc/UserInfo/controller/user_info_controller.dart';

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
    return Expanded(
      child: SingleChildScrollView(
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
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: userInfoController.nameController.text.isEmpty
                      ? const Color(0xffFFC056)
                      : const Color(0xff009C56),
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
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: userInfoController.emailController.text.isEmpty
                      ? const Color(0xffFFC056)
                      : const Color(0xff009C56),
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
            inputHeader(context,'Semester'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: userInfoController.selectedValueCategory == null
                    ? const Color(0xffFFC056)
                    : const Color(0xff009C56),
                ),
              ),
              child: DropdownButton<int>(
                  dropdownColor: Colors.grey.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  autofocus: true,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  underline: const SizedBox(),
                  hint:  Text('Select Category',style: TextStyle(color: Colors.grey.shade500),),
                  isExpanded: true,
                  value: userInfoController.selectedValueCategory,
                  icon:  Icon(Icons.keyboard_arrow_down,
                      size: textSize*2,
                      color: userInfoController.selectedValueCategory == null
                          ? const Color(0xffFFC056)
                          : const Color(0xff009C56)),
                  onChanged: (int? newValue) async {

                    userInfoController.selectedValueCategory = newValue;
                    userInfoController.selectedValueDepartment = null;
                    userInfoController.selectedValueSemester = null;
                    userInfoController.saveButtonEnable();
                    setState(() {});
                  },
                  items: semesterItems(),
                )
            ),
            inputHeader(context,'Department'),
            Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: userInfoController.selectedValueDepartment == null
                            ? const Color(0xffFFC056)
                            : const Color(0xff009C56),
                        ),
                      ),
                      child: DropdownButton<int>(
                        dropdownColor: Colors.grey.shade100,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        autofocus: true,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        underline: const SizedBox(),
                        hint: Text('Select Department',style: TextStyle(color: Colors.grey.shade500)),
                        isExpanded: true,
                        value: userInfoController.selectedValueDepartment,
                        icon:  Icon(Icons.keyboard_arrow_down,
                          size: textSize*2,
                          color: userInfoController.selectedValueDepartment == null
                              ? const Color(0xffFFC056)
                              : const Color(0xff009C56),
                        ),
                        onChanged: (int? newValue) {
                          userInfoController.selectedValueDepartment = newValue;
                          userInfoController.selectedValueSemester = null;
                          userInfoController.saveButtonEnable();
                          setState(() {});
                        },
                        items: semesterItems(),
                      )
                  ),

            inputHeader(context,'Semester/Course'),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all( color:  userInfoController.selectedValueSemester == null
                      ? const Color(0xffFFC056)
                      : const Color(0xff009C56),
                  ),
                ),
                child:DropdownButton<int>(
                  dropdownColor: Colors.grey.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  autofocus: true,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  underline: const SizedBox(),
                  hint:  Text('Select Course',style: TextStyle(color: Colors.grey.shade500),),
                  isExpanded: true,
                  value: userInfoController.selectedValueSemester,
                  icon:  Icon(Icons.keyboard_arrow_down,
                    size: textSize*2,
                    color:userInfoController.selectedValueSemester == null
                        ? const Color(0xffFFC056)
                        : const Color(0xff009C56),
                  ),
                  onChanged: (int? newValue) {
                    userInfoController.selectedValueSemester = newValue;
                    userInfoController.saveButtonEnable();
                    setState(() {});
                  },
                  items: semesterItems(),
                )
            ),

          ],
        ),
      ),
    );
  }

  Widget saveButton(){
    return userInfoController.saveButtonEnableFlag.value
        ? InkWell(
        onTap: () {
          userInfoController.userNameInputValidation();
          userInfoController.userEmailInputValidation();
          if(userInfoController.inputValidUserName.value && userInfoController.inputValidUserEmail.value){
          }
        },
        child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  gradient: const LinearGradient(colors: [
                    Color(0xffF5244F),
                    Color(0xffFAA64B),
                  ])),
              child: Text(
                'Save',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'HindSiliguri',
                    fontSize: textSize),
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
