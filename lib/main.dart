import 'package:flutter/material.dart';
import 'UserInfo/view/user_info_screen.dart';
import 'api.dart';

void main() async{
  await UserSheetApi.inti();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NUBCC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home:  const UserInfoScreen(),
      // builder: FlutterSmartDialog.init(
      //   toastBuilder: (String msg) => Center(
      //     child: Container(
      //       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
      //           color: Colors.red),
      //       child: Text(msg,
      //         style:  const TextStyle(
      //           color: Colors.white,
      //           fontSize: 18,
      //         ),
      //       ),
      //     ),
      //   ),
      //   loadingBuilder: (String msg) => LoadingAnimationWidget.hexagonDots(
      //       color: Colors.green,
      //       size:  20
      //   ),
      // ),
    );
  }
}

