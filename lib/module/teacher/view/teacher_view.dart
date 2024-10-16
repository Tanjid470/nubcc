
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nubcc/config/size_config.dart';
import 'package:nubcc/const/app_colors.dart';
import 'package:nubcc/const/font_constant.dart';
import 'package:nubcc/module/teacher/data/teacher_data_link.dart';

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
      appBar: AppBar(title: const Text("Teacher"),centerTitle: true,),
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
            child: GridView.builder(
              controller: scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: TeacherDataLink.teachersList.length + 1,
              itemBuilder: (context, index) {
                if(index < TeacherDataLink.teachersList.length){
                  final student = TeacherDataLink.teachersList[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.5),
                            ),
                            child: Text(student.name[0].toUpperCase(),
                              style: TextStyle(fontSize: TextSize.font36(context)),
                            )
                        ),
                        Text(student.name, style: const TextStyle(fontWeight: FontWeight.bold)), // Display student name
                        Text(student.university), // Display student university
                      ],
                    ),
                  );
                }
                else{
                    if(hasMoreData == false){
                      return Center(child: Text(TeacherDataLink.teachersList.length.toString()));
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
