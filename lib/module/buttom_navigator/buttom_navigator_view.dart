import 'package:flutter/material.dart';
import 'package:nubcc/const/app_colors.dart';
import 'package:nubcc/const/font_constant.dart';
import 'package:nubcc/module/home/view/home_screen.dart';
import 'package:nubcc/module/location/view/location_view.dart';
import 'package:nubcc/module/profile/view/profile_view.dart';

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
         LocationView(),
         ProfileView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: selectedIndex == 0 ? const Icon(Icons.home) : const Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: selectedIndex == 1 ? const Icon(Icons.location_on) : const Icon(Icons.location_on_outlined), label: 'Location'),
          BottomNavigationBarItem(icon:selectedIndex == 2 ? const Icon(Icons.person) : const Icon(Icons.person_2_outlined), label: 'Profile'),
        ],
        currentIndex: selectedIndex,
        unselectedItemColor: AppColor.baseColorShade300,
        selectedIconTheme:  IconThemeData(color: AppColor.baseColor,),
        iconSize: TextSize.font36(context),
        selectedFontSize: TextSize.font15(context),
        selectedItemColor: AppColor.baseColor,

        onTap: onTapped,
      ),
    );
  }
}