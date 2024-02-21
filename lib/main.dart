
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medtrack/graphs.dart';
import 'package:medtrack/history.dart';
import 'package:medtrack/medications.dart';
import 'package:medtrack/openPage.dart';
import 'package:medtrack/pages/about.dart';
import 'package:medtrack/pages/dash.dart';
import 'package:medtrack/pages/elderlayout.dart';
import 'package:medtrack/pages/help.dart';
import 'package:medtrack/provider/theme_provider.dart';
import 'package:medtrack/register.dart';
import 'package:medtrack/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medtrack/settingsSOS.dart';
import 'package:medtrack/test_noti.dart';
import 'package:medtrack/updateSoS.dart';
import 'package:medtrack/geminiapi/bot.dart';
import 'package:provider/provider.dart';
import 'package:medtrack/pages/expense_home.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    await FirebaseApi().initializeNotifications();
    await initializeNotifications();
  } catch (e) {
    print(e);
  }
  

  runApp(MyApp());
   DateTime now = DateTime.now();
  DateTime afterOneMinute = now.add(Duration(minutes: 1));

  
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, child) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Stuck Service',
            initialRoute: 'MyHomePage',
            themeMode: themeProvider.mode,
            routes: {
              'MyHomePage': (context) => MyHomePage(),
              'register': (context) => MyRegister(),
              'homepage': (context) => HomePage(),
              'medications': (context) => Medications(),
              'settingsSOS': (context) => settingsSOS(),
              'updateSOS': (context) => updateSOS(),
              'graphs': (context) => graphs(),
              'history': (context) => History(),
              'bot': (context) => BotHome(),
              'dashboard': (context) => DashPage(),
              'elderlayout':(context) => ElderPage(),
              'about':(context) => AboutPage(),
              'help': (context) => HelpPage(),
            },
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var auth = FirebaseAuth.instance;
  var isLogin = false;

  checkIfLogin() async {
    auth.authStateChanges().listen((User? user) {
        if(user != null && mounted) {
          setState(() {
            isLogin = true;
          });
        }
    });
  }

@override
  void initState() {
    checkIfLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child:
            isLogin ? DashPage() : OpenPage(),
    ));
  }
}
