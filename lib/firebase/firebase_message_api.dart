
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nubcc/firebase/view/notification_screen.dart';
import 'package:nubcc/main.dart';


  Future<void> handleBackgroundMessage(RemoteMessage message) async {

  }
  void handleMessage(RemoteMessage? message) async {
    if(message == null ) return;
    navigatorKey.currentState?.pushNamed(
      NotificationScreen.route,
      arguments: message,
    );
  }

  Future intiPushNotification() async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  class FirebaseMessageAPI{
    final _firebaseMessaging = FirebaseMessaging.instance;

    Future<void> initNotifications() async{
      await _firebaseMessaging.requestPermission();
      final fCMToken = await _firebaseMessaging.getToken();
      print('Token : $fCMToken');
      intiPushNotification();
    }

  }