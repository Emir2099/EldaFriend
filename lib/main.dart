import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medtrack/graphs.dart';
import 'package:medtrack/history.dart';
import 'package:medtrack/medications.dart';
import 'package:medtrack/openPage.dart';
import 'package:medtrack/pages/dash.dart';
import 'package:medtrack/register.dart';
import 'package:medtrack/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medtrack/settings.dart';
import 'package:medtrack/updateSoS.dart';
import 'package:medtrack/geminiapi/bot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    await initializeNotifications();
  } catch (e) {
    print(e);
  }

  runApp(const MyApp());
}

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await FlutterLocalNotificationsPlugin().initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (payload) async {
      // This callback is triggered when the user taps on the notification
      print("User tapped on the notification!");
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stuck Service',
      initialRoute: 'MyHomePage',
      routes: {
        'MyHomePage': (context) => const MyHomePage(),
        'register': (context) => const MyRegister(),
        'homepage': (context) => HomePage(),
        'medications': (context) => Medications(),
        'settings': (context) => Settings(),
        'updateSOS': (context) => updateSOS(),
        'graphs': (context) => graphs(),
        'history': (context) => History(),
        'bot': (context) => const Bot(),
        'dashboard': (context) => DashPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
      child: //AuthService().handleAuthState(),
          Bot(),
    ));
  }
}
