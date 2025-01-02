import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nubcc/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'const/font_constant.dart';
import 'firebase/firebase_message_api.dart';
import 'firebase/view/notification_screen.dart';
import 'google_sheet_init.dart';
import 'module/UserInfo/view/user_info_screen.dart';

late SharedPreferences preferences;
int? isInitScreen;

final navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseOptions options = await firebaseInit();
  await Firebase.initializeApp(options: options);
  await FirebaseMessageAPI().initNotifications();

  await GoogleSheetInit().inti();
  preferences = await SharedPreferences.getInstance();
  isInitScreen = preferences.getInt('initScreen');
  runApp(const MyApp());
}

Future<FirebaseOptions> firebaseInit() async{

  String googleServicesJsonString = await rootBundle.loadString('android\\app\\google-services.json');
  final googleServicesJson = jsonDecode(googleServicesJsonString);
  final projectId = googleServicesJson['project_info']["project_id"];

  final messagingSenderId = googleServicesJson['project_info']["project_number"];
  final storageBucket = googleServicesJson['project_info']["storage_bucket"];
  final appId = googleServicesJson['client'][0]["client_info"]["mobilesdk_app_id"];
  final apiKey = googleServicesJson['client'][0]["api_key"][0]["current_key"];

  FirebaseOptions options = FirebaseOptions(
    apiKey: apiKey,
    appId: appId,
    messagingSenderId: messagingSenderId,
    projectId: projectId,
    storageBucket: storageBucket,
  );

  return options;
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
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: FlutterSmartDialog.init(
        toastBuilder: (String msg) => Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Colors.red.shade300
            ),
            child: Text(msg,
              style:   TextStyle(
                color: Colors.white,
                fontSize: TextSize.font16(context),
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
      navigatorKey: navigatorKey,
      routes: {
        NotificationScreen.route: (context) => const NotificationScreen()
      },
    );
  }
}

