
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:nubcc/main.dart';
import 'package:nubcc/module/UserInfo/view/user_info_screen.dart';
import 'package:nubcc/module/buttom_navigator/buttom_navigator_view.dart';
import 'package:nubcc/module/clubCommittee/view/club_committee_screen.dart';
import 'package:nubcc/module/home/view/home_screen.dart';
import 'package:nubcc/module/teacher/view/teacher_view.dart';

part 'app_routes.dart';
class AppPages{
  AppPages._();

  static String INITIAL = isInitScreen == 0 || isInitScreen == null
      ? Routes.userInfoScreen
      : Routes.bottomNavigationWidget;
  static final routes =[
    GetPage(
      name:_Paths.bottomNavigationWidget,
      page: () => const BottomNavigationWidget(),
      transition: Transition.leftToRight,
      curve: Curves.fastOutSlowIn,
    ),
    GetPage(
      name:_Paths.homeScreen,
      page: () => const HomeScreen(),
      transition: Transition.leftToRight,
      curve: Curves.fastOutSlowIn,
    ),
    GetPage(
      name:_Paths.userInfoScreen,
      page: () => const UserInfoScreen(),
      transition: Transition.leftToRight,
      curve: Curves.fastOutSlowIn,
    ),
    GetPage(
      name:_Paths.teacherView,
      page: () => const TeacherView(),
      transition: Transition.rightToLeft,
      curve: Curves.fastOutSlowIn,
    ),
    GetPage(
      name:_Paths.clubCommitteeView,
      page: () => const ClubCommitteeView(),
      transition: Transition.rightToLeft,
      curve: Curves.fastOutSlowIn,
    ),
  ];
}