
import 'package:get/get.dart';
import 'package:nubcc/module/teacher/data/teacher_data_link.dart';

class HomeController extends GetxController{


  var selectedPage = 0.obs;
  void changePage(int value) {
    selectedPage.value = value;
  }

  List<String> splashList = [
    "first",
    "Second"
  ];
}