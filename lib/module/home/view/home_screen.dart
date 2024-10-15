

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nubcc/config/responsive_scale.dart';
import 'package:nubcc/const/app_colors.dart';
import 'package:nubcc/const/font_constant.dart';
import 'package:nubcc/module/home/controller/home_controller.dart';
import 'package:nubcc/module/teacher/data/teacher_data_link.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
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
    return  Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          verticalGap(context, 1),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: Get.height * 0.3,
                child: CarouselSlider.builder(
                  itemCount: homeController.splashList.length,
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    return Container(
                      color: Colors.red,
                    );
                  },
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height, // Adjust height accordingly
                    autoPlay: true,  // Enable auto-play
                    autoPlayInterval: const Duration(seconds: 3),  // Time between transitions
                    enlargeCenterPage: true, // Enlarge the current item
                    viewportFraction: 1.0, // Display one item at a time
                    onPageChanged: (index, reason) {
                      homeController.changePage(index);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(homeController.splashList.length, (index) {
                  return InkWell(
                    onTap: () => homeController.changePage(index),
                    child: Container(
                      width: homeController.selectedPage.value == index ? 20.0 : 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: const BorderRadius.all(Radius.circular(7)),
                        color: homeController.selectedPage.value == index
                            ? Colors.deepOrange
                            : Colors.grey.shade300,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator()) // Show loading spinner while data is being fetched
              : ListView.builder(
                shrinkWrap: true,
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
        ],
      ),
    );
  }

  SizedBox verticalGap(BuildContext context,double ratio) =>
      SizedBox(height: ResponsiveScale.of(context).hp(ratio));
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height/10,
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xff0346ae).withOpacity(.8),
              AppColor.baseColor,
            ],
            begin:  Alignment.topCenter,
            end : Alignment.bottomCenter,
        ),

        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)
        )
      ),
      child: Text("NUBCC",
        style: TextStyle(
          color: Colors.white,
          fontSize: TextSize.font20(context),
          fontWeight:FontWeight.w500
        ),),
    );
  }
}
