part of 'app_pages.dart';
abstract class Routes {
  Routes._();
  static const homeScreen = _Paths.homeScreen;
  static const userInfoScreen = _Paths.userInfoScreen;
  static const teacherView = _Paths.teacherView;
  static const clubCommitteeView = _Paths.clubCommitteeView;
  static const bottomNavigationWidget = _Paths.bottomNavigationWidget;
  static const loginView = _Paths.loginView;
}

abstract class _Paths {
  _Paths._();
  static const homeScreen = '/home_screen';
  static const userInfoScreen = '/user_info_screen';
  static const teacherView = '/teacher_view';
  static const clubCommitteeView = '/club_committee_view';
  static const bottomNavigationWidget = '/bottom_navigation_widget';
  static const loginView = '/login_view';
}