
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:nubcc/main.dart';
import 'package:nubcc/module/UserInfo/view/user_info_screen.dart';
import 'package:nubcc/module/home/view/home_screen.dart';
import 'package:nubcc/module/teacher/view/teacher_view.dart';

part 'app_routes.dart';
class AppPages{
  AppPages._();

  static String INITIAL = isInitScreen == 0 || isInitScreen == null
      ? Routes.userInfoScreen
      : Routes.homeScreen;
  static final routes =[
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
  ];
}