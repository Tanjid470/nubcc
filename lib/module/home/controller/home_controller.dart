
import 'package:get/get.dart';
import 'package:nubcc/const/app_images.dart';
import 'package:nubcc/module/teacher/data/teacher_data_link.dart';

class HomeController extends GetxController{


  var selectedPage = 0.obs;
  void changePage(int value) {
    selectedPage.value = value;
  }

  List<String> splashList = [
   AppImages.splashOne,
   AppImages.splashTwo,
   AppImages.splashThree,
   AppImages.splashFour,
   AppImages.splashFive,
   AppImages.splashSix,
   AppImages.splashSeven,
   AppImages.splashEight,
  ];
}