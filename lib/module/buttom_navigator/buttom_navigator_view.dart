import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nubcc/const/app_colors.dart';
import 'package:nubcc/const/app_images.dart';
import 'package:nubcc/const/font_constant.dart';
import 'package:nubcc/module/home/view/home_screen.dart';
import 'package:nubcc/module/location/view/location_view.dart';
import 'package:nubcc/module/profile/view/profile_view.dart';

import '../calculator/caloculator_view.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  _BottomNavigationWidgetState  createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int selectedIndex = 0;
  PageController pageController = PageController();
  /* List<Widget> widgets=[
    Text('Home'),
    Text('Search'),
    Text('Add'),
    Text('Profile'),
  ];*/
  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const [
         HomeScreen(),
         CgpaCalculator(),
         ProfileView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Container(
            height: Get.height/30,
            width: Get.height/30,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: selectedIndex == 0
                        ? AssetImage(AppImages.homeIcon)
                        : AssetImage(AppImages.unselectedHome)
                )
            ),
          ),label: 'Home'),
          BottomNavigationBarItem(icon: Container(
            height: Get.height/30,
            width: Get.height/30,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: selectedIndex == 1
                        ? AssetImage(AppImages.locationIcon)
                        : AssetImage(AppImages.unselectedLocation)
                )
            ),
          ),label: 'Location'),
          BottomNavigationBarItem(icon: Container(
            height: Get.height/30,
            width: Get.height/30,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: selectedIndex == 2
                        ? AssetImage(AppImages.profileIcon)
                        : AssetImage(AppImages.unselectedProfile)
                )
            ),
          ),label: 'Profile'),

        ],
        currentIndex: selectedIndex,
        unselectedItemColor: AppColor.iconColor,
        selectedIconTheme:  IconThemeData(color: AppColor.baseColor,),
        iconSize: TextSize.font36(context),
        selectedFontSize: TextSize.font14(context),
        selectedItemColor: AppColor.baseColor,
        onTap: onTapped,
      ),
    );
  }
}