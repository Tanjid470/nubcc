
import 'package:get/get.dart';

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