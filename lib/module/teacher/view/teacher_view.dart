
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nubcc/config/responsive_scale.dart';
import 'package:nubcc/const/app_colors.dart';
import 'package:nubcc/const/font_constant.dart';
import 'package:nubcc/module/teacher/data/teacher_data_link.dart';
import 'package:nubcc/module/teacher/model/teacher_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../global/widget/link_button_card.dart';

class TeacherView extends StatefulWidget {
  const TeacherView({super.key});

  @override
  State<TeacherView> createState() => _TeacherViewState();
}

class _TeacherViewState extends State<TeacherView> {

  final ScrollController scrollController = ScrollController();

  bool isLoading = true;
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    fetchStudentData();
    scrollController.addListener(() async {
      if(scrollController.position.maxScrollExtent == scrollController.offset){
        fetchStudentData();
        setState(() {});
      }
    },);
  }

  void fetchStudentData() async {
    hasMoreData = await TeacherDataLink.initAndFetchData();
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher",
          style: TextStyle(

            letterSpacing: 5,
            fontSize: TextSize.font24(context),
            fontWeight: FontWeight.w700,
            color: AppColor.baseColor
          ),
        ),
        centerTitle: true,
        foregroundColor: AppColor.baseColor,
        shadowColor: AppColor.baseColorShade500,
        surfaceTintColor: Colors.blueAccent,
      ),
      body: isLoading
          ? Center(
            heightFactor: 10,
            child: LoadingAnimationWidget.hexagonDots(
                color: AppColor.baseColor,
                size: Get.height/10
            ),
          ) // Show loading spinner while data is being fetched
          : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView.builder(
              controller: scrollController,
              itemCount: TeacherDataLink.teachersList.length + 1,
              itemBuilder: (context, index) {
                if(index < TeacherDataLink.teachersList.length){
                  final teacher = TeacherDataLink.teachersList[index];
                  return TeacherCard(teacher: teacher);
                }
                else{
                    if(hasMoreData == false){
                      return Center(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColor.baseColorShade500,
                              shape: BoxShape.circle
                            ),
                            child: Text(TeacherDataLink.teachersList.length.toString())
                          )
                      );
                    }
                    else{
                      return Center(
                        heightFactor: 10,
                        child: LoadingAnimationWidget.hexagonDots(
                            color: AppColor.baseColor,
                            size:  Get.height / 15
                        ),
                      );
                    }
                  }
                }
            ),
          )
    );
  }
}

class TeacherCard extends StatelessWidget {
  const TeacherCard({
    super.key,
    required this.teacher,
  });

  final TeacherModel teacher;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      margin: const EdgeInsets.only(bottom: 10),
      decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
              color: AppColor.baseColor.withOpacity(.2)
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1
            )
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.5),
              ),
              child: Text(teacher.name != null && teacher.name!.isNotEmpty
                  ? teacher.name![0].toUpperCase()
                  : '',
                style: TextStyle(fontSize: TextSize.font36(context)),
              )
          ),
          SizedBox(width: ResponsiveScale.of(context).wp(2)),
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(teacher.name ?? "unknown", style: const TextStyle(fontWeight: FontWeight.bold)), // Display student name
                  Text(teacher.title ?? " --- "),
                  Text(teacher.university ?? " --- "),
                  Text(teacher.contact ?? " --- "),
                  Text(teacher.email ?? "Null"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LinkButtonCard(icon: Icons.call, title: 'Call',
                        onTap: () {
                          if(teacher.contact != null && teacher.contact!.isNotEmpty) {
                          makePhoneCall("0${teacher.contact.toString()}");
                          }
                          else{
                            SmartDialog.showToast('number not available',);}
                        }
                      ),
                      LinkButtonCard(icon: Icons.email_outlined, title: 'Email',
                        onTap: () {
                          sentMail(teacher.email.toString());
                        },),
                      LinkButtonCard(icon: Icons.library_add_outlined, title: 'LinkedIn', onTap: () {  },)

                    ],
                  )
                ],)
          ),
        ],
      ),
    );
  }
  void makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void sentMail(String email) async {
    String? emailCheck= userEmailInputValidation(email);
    if(emailCheck == null){
      final Uri launchUri = Uri(
        scheme: 'mailto',
        path: email,
      );
      await launchUrl(launchUri);
      SmartDialog.showToast("sent");
    }
    else{
      SmartDialog.showToast(emailCheck);
    }
  }
  String? userEmailInputValidation(String email){
    bool emailValid = RegExp(
        r"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
    ).hasMatch(email);

    if(email.isEmpty){
      return "email is empty";
    }
    else if(emailValid != true){
     return "not a valid email";
    }
    return null;
  }
}
