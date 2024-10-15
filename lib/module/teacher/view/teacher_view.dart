
import 'package:flutter/material.dart';
import 'package:nubcc/module/teacher/data/teacher_data_link.dart';

class TeacherView extends StatefulWidget {
  const TeacherView({super.key});

  @override
  State<TeacherView> createState() => _TeacherViewState();
}

class _TeacherViewState extends State<TeacherView> {

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudentData();
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
      appBar: AppBar(title: Text("Teacher"),),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner while data is being fetched
          : ListView.builder(
            itemCount: TeacherDataLink.teachersList.length,
            itemBuilder: (context, index) {
              final student = TeacherDataLink.teachersList[index];
              return ListTile(
                leading: CircleAvatar(child: Text(student.id)), // Display student ID
                title: Text(student.name), // Display student name
                subtitle: Text(student.university), // Display student university
              );
            },
          ),
      
    );
  }
}
