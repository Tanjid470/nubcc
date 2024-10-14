part of 'app_pages.dart';
abstract class Routes {
  Routes._();
  static const homeScreen = _Paths.homeScreen;
  static const userInfoScreen = _Paths.userInfoScreen;

}

abstract class _Paths {
  _Paths._();
  static const homeScreen = '/home_screen';
  static const userInfoScreen = '/user_info_screen';
}