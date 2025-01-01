import 'dart:convert';

import 'package:firebase_app_installations/firebase_app_installations.dart';
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
import 'google_sheet_init.dart';
import 'module/UserInfo/view/user_info_screen.dart';

late SharedPreferences preferences;
int? isInitScreen;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
// Load the google-services.json file as a string
  String googleServicesJsonString =
  await rootBundle.loadString('android\\app\\google-services.json');
  print("google_Services_Json_String: $googleServicesJsonString");

  // Parse the JSON String into a JSON
  final googleServicesJson = jsonDecode(googleServicesJsonString);
  final projectId = googleServicesJson['project_info']["project_id"];
  print("projectId: $projectId");
  final messagingSenderId =
  googleServicesJson['project_info']["project_number"];
  print("messagingSenderId: $messagingSenderId");
  final storageBucket = googleServicesJson['project_info']["storage_bucket"];
  print("storageBucket: $storageBucket");
  final appId =
  googleServicesJson['client'][0]["client_info"]["mobilesdk_app_id"];
  print("appId: $appId");
  final apiKey = googleServicesJson['client'][0]["api_key"][0]["current_key"];
  print("apiKey: $apiKey");

  // Create a FirebaseOptions object from the extracted configuration
  FirebaseOptions options = FirebaseOptions(
    apiKey: apiKey,
    appId: appId,
    messagingSenderId: messagingSenderId,
    projectId: projectId,
    storageBucket: storageBucket,
  );

  // Initialize Firebase with the options
  await Firebase.initializeApp(options: options);
  _getInstallationId();
  print('Firebase app is initialized!');
  await FirebaseMessageAPI().initNotifications();

  await GoogleSheetInit().inti();
  preferences = await SharedPreferences.getInstance();
  isInitScreen = preferences.getInt('initScreen');
  runApp(const MyApp());
}

String? _installationId;

Future<void> _getInstallationId() async {
  try {
    _installationId = await FirebaseInstallations.instance.getId();
    print('Installation ID-----------------------------------------------------------: $_installationId');
  } catch (e) {
    print('Error getting Installation ID----------------------------------------: $e');
  }
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
    );
  }
}

