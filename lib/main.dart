import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nubcc/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'google_sheet_init.dart';
import 'module/UserInfo/view/user_info_screen.dart';

late SharedPreferences preferences;
int? isInitScreen;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleSheetInit().inti();
  preferences = await SharedPreferences.getInstance();
  isInitScreen = preferences.getInt('initScreen');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      title: 'NUBCC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home:  const UserInfoScreen(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: FlutterSmartDialog.init(
        toastBuilder: (String msg) => Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                color: Colors.red
            ),
            child: Text(msg,
              style:  const TextStyle(
                color: Colors.white,
                fontSize: 100,
              ),
            ),
          ),
        ),
        loadingBuilder: (String msg) => LoadingAnimationWidget.hexagonDots(
            color: const Color(0xff0346ae),
            size: 100
        ),
      ),
      navigatorObservers: [FlutterSmartDialog.observer],
    );
  }
}

