import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medtrack/comunities/screens/home_screen.dart';
// import 'package:medtrack/Community/screens/home_screen.dart';
import 'package:medtrack/geminiapi/bot.dart';
import 'package:medtrack/graphs.dart';
import 'package:medtrack/helper/helper_function.dart';
import 'package:medtrack/homePage.dart';
import 'package:medtrack/medications.dart';
// import 'package:medtrack/newCard.dart';
import 'package:medtrack/openPage.dart';
import 'package:medtrack/servies/auth.dart';
import 'package:medtrack/settingsSOS.dart';
import 'package:medtrack/util/functions_tile.dart';
import 'package:medtrack/util/icon1.dart';
import 'package:medtrack/util/icon2.dart';
import 'package:medtrack/util/icon3.dart';
import 'package:medtrack/util/icon4.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class DashPage extends StatefulWidget {
  const DashPage({Key? key}) : super(key: key);

  @override
  State<DashPage> createState() => _DashPageState();
}


final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? user = _auth.currentUser;
bool showSpinner = false;
Map<String, dynamic> dataOfUser = {};


 const _backgroundColor = Color.fromARGB(255, 255, 255, 255);

const _colors = [
    Color(0xFFFEE440),
    Color.fromARGB(255, 52, 219, 19),
];

const _durations = [
    5000,
    4000,
];

const _heightPercentages = [
    0.45,
    0.46,
];

class _DashPageState extends State<DashPage> {
void initState() {
    // TODO: implement initState
    getDataOfUser();
     //////////////test
    super.initState();
  }



  void getDataOfUser() async {
    setState(() {
      showSpinner = true;
    });
    print(user?.uid);
    final events =
        await _firestore.collection('users').doc(user?.uid).get();
    if (events != null) {
      dataOfUser['email'] = events['email'];
      dataOfUser['name'] = events['fullName'];
    }
    setState(() {
      showSpinner = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (dataOfUser['name']).toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        ("${DateTime.now().day}-"+"${DateTime.now().month}-"+"${DateTime.now().year}"),
                        style: TextStyle(color: Colors.blue[100]),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: 
                          GestureDetector(
                            onTap: () {
                              Auth().signoutUser().whenComplete(() async {
                  await HelperFunction
                      .saveUserLoggedInStatusToSharedPreferences(false);
                  await HelperFunction.saveUsernameToSharedPreferences("");
                  await HelperFunction.saveUserEmailToSharedPreferences("");
                  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>  OpenPage(),
      ),
    );
                });
                            },
                            child: Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Container(
                height: 40,
                    width: double.infinity,
                child: Card(
                  elevation: 12.0,
                      margin: EdgeInsets.only(
                          right: 10, left: 10, bottom: 16.0),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0))),
              
                  child: WaveWidget(
                  config: CustomConfig(
                      colors: _colors,
                      durations: _durations,
                      heightPercentages: _heightPercentages,
                  ),
                  backgroundColor: _backgroundColor,
                  size: Size(double.infinity, double.infinity),
                  waveAmplitude: 0.1,
                                ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Base Functionalities',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BotHome()),
                        );
                      },
                      child: Icon1(),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('AI', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                     onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BotHome()),
                        );
                      },
                    child: Icon2(),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Water Rem.', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                     GestureDetector(
                     onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Medications()),
                        );
                      },
                    child: Icon3(),
                     ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('SOS', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Icon4(),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Settings', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                padding: EdgeInsets.all(25),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Main Functionalities',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Icon(Icons.more_horiz),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            InkWell(
                              onTap: () {
                                 Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BotHome()),
    );
                              },
                              child: Card(
                                elevation: 3.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1.0),
                                  child: FunctionTile(
                                    icon: Icons.switch_account,
                                    functionName: 'Switch Mode',
                                    functionSub:
                                        'Elder Friendly Interface',
                                    color: Colors.lime[300],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                 Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
                              },
                              child: Card(
                                elevation: 3.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1.0),
                                  child: FunctionTile(
                                    icon: Icons.medication_liquid_rounded,
                                    functionName: 'Medicine Reminder',
                                    functionSub: "Don't miss a dose",
                                    color: Colors.green[300],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                 Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => graphs()),
    );
                              },
                              child: Card(
                                elevation: 3.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1.0),
                                  child: FunctionTile(
                                    icon: Icons.insert_chart_outlined_rounded,
                                    functionName: 'View Reports',
                                    functionSub: 'Detailed Analytics',
                                    color: Colors.pink[300],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                 Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
                              },
                              child: Card(
                                elevation: 3.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1.0),
                                  child: FunctionTile(
                                    icon: Icons.mark_chat_unread_rounded,
                                    functionName: 'Communities',
                                    functionSub:
                                        'Interact with people ',
                                    color: Colors.purple[300],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
