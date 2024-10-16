
import 'dart:math';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    fetchStudentData();
    scrollController.addListener(() async {
      if(scrollController.position.maxScrollExtent == scrollController.offset){
        // bool reFetch = await eBooksController.setAllEbooks(eBooksController.allEbookObject.next!);
        // if(reFetch){
        //   setState(() {});
        // }
      }
    },);
  }

  void fetchStudentData() async {
    await TeacherDataLink.initAndFetchData(); // Fetch data from Google Sheets
    setState(() {
      isLoading = false; // Set loading to false after fetching data
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teacher"),centerTitle: true,),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading spinner while data is being fetched
          : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: TeacherDataLink.teachersList.length,
              itemBuilder: (context, index) {
                final student = TeacherDataLink.teachersList[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
              },
            ),
          )


    );
  }
}
