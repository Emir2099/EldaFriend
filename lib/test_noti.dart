import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackGroundMessage(RemoteMessage message)async{
  print("title ${message.notification?.title}");
  print("boyd ${message.notification?.body}");
  print("paytload ${message.data}");
}

class FirebaseApi{
  final _firebaseMessages= FirebaseMessaging.instance;
  Future<void> initializeNotifications() async{
    await _firebaseMessages.requestPermission();
    final fCMToken = await _firebaseMessages.getToken();
    print("Toke $fCMToken");
    FirebaseMessaging.onBackgroundMessage(handleBackGroundMessage);
  }
}