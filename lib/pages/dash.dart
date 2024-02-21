import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medtrack/comunities/screens/home_screen.dart';
import 'package:medtrack/geminiapi/bot.dart';
import 'package:medtrack/graphs.dart';
import 'package:medtrack/helper/helper_function.dart';
import 'package:medtrack/homePage.dart';
import 'package:medtrack/medications.dart';
import 'package:medtrack/openPage.dart';
import 'package:medtrack/pages/elderlayout.dart';
import 'package:medtrack/pages/expense_home.dart';
import 'package:medtrack/pages/help.dart';

import 'package:medtrack/screens/main_settings_screen.dart';
import 'package:medtrack/servies/auth.dart';
import 'package:medtrack/settingsSOS.dart';
import 'package:medtrack/util/functions_tile.dart';
import 'package:medtrack/util/icon1.dart';
import 'package:medtrack/util/icon2.dart';
import 'package:medtrack/util/icon3.dart';
import 'package:medtrack/util/icon4.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:intl/intl.dart';

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
List<dynamic> dataOfTakedMed = [];
  bool _isPressed1 = false;
  bool _isPressed2 = false;
  bool _isPressed3 = false;
  bool _isPressed4 = false;
  bool _isPressedB1 = false;
  bool _isPressedB2 = false;
  bool _isPressedB3 = false;
  bool _isPressedB4 = false;

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

List datalisttaked = [];
class _DashPageState extends State<DashPage> {
  
  DateTime selectedDay = DateTime.now();
void initState() {
    // TODO: implement initState
    getDataOfUser();
    datalisttaked = [];
     //////////////test
     getTheMedicines();
    getTheTakedMedicines();
    super.initState();
  }
  
  Future<void> getTheMedicines() async {
    setState(() {
      showSpinner = true;
    });

    await FirebaseFirestore.instance
        .collection('medicines')
        .doc(user!.email)
        .collection('dates')
        .doc(DateFormat("dd.MM.yy").format(selectedDay))
        .collection('medicinesList')
        .get()
        .then((querySnapshot) {
      List<Map<String, dynamic>> dataList = [];
      List<String> Events = [];
      Events.add(DateFormat("dd.MM.yy").format(selectedDay));
      querySnapshot.docs.forEach((doc) {
        dataList.add(doc.data());
        Events.add(doc.data()['medTime'].toString());
      });
      dataList.sort((a, b) => a["medTime"].compareTo(b["medTime"]));
      print("this is the lengthhhhjkjkkj${dataList.length}");
      print(timeEvents);
      medInDate = dataList;
      print("This the medddindateeee${medInDate.length}");
      timeEvents = Events;

      setState(() {
        showSpinner = false;
      });
    }).catchError((error) {
      print("Error getting documents: $error");
      setState(() {
        showSpinner = false;
      });
    });
  }
Future<String> getGlobalPin() async {
  final doc = await FirebaseFirestore.instance.collection('users').doc(user!.email).get();
  return doc['globalPin'];
}

  Future<void> getTheTakedMedicines() async {
    setState(() {
      showSpinner = true;
    });
    var day = selectedDay.day;
    var month = selectedDay.month;
    await FirebaseFirestore.instance
        .collection('Taked')
        .where('takedDate', isEqualTo: DateFormat("dd.MM.yy").format(selectedDay)).where('usermail',isEqualTo: user!.email)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        datalisttaked.add(doc.data());
      });
      datalisttaked.sort((a, b) => b["medDate"].compareTo(a["medDate"]));
      datalisttaked.sort((a, b) => b["takedAt"].compareTo(a["takedAt"]));
      print("Plzzzz medicine${datalisttaked.length}");
      setState(() {
        showSpinner = false;
      });
    }).catchError((error) {
      print("Error getting documents: $error");
      setState(() {
        showSpinner = false;
      });
    });
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
                      Text('Hi '+
                        (dataOfUser['name']).toString()+"!",
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
  DateFormat('d MMMM yyyy').format(DateTime.now()),
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
                  Navigator.pushReplacement( context,MaterialPageRoute( builder: (context) =>  HelpPage(),),);
     
                },
                            
                            child: Icon(
                              Icons.question_mark_sharp,
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
      margin: EdgeInsets.only(right: 10, left: 10, bottom: 16.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0))),
      child: SimpleAnimationProgressBar(
        height: 30,
        width: 400,
        backgroundColor: Colors.grey.shade800,
        foregrondColor: Color.fromARGB(255, 26, 233, 8),
        ratio:datalisttaked.isEmpty ? 0/1 : datalisttaked.length.toDouble() / medInDate.length.toDouble(),
       // calculate the ratio
        direction: Axis.horizontal,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(10),
        gradientColor: const LinearGradient(
          colors: [Colors.pink, Colors.purple]
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.pink,
            offset: Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
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
                  onTapDown: (details) {
                    setState(() {
                      _isPressed1 = true;
                    });
                  },
                  onTapUp: (details) {
                    setState(() {
                      _isPressed1 = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BotHome()),
                    );
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeOut,
                    child: Transform.translate(
                      offset: Offset(0, _isPressed1 ? 10 : 0),
                      child: Icon1(), 
                    ),
                  ),
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
                  onTapDown: (details) {
                    setState(() {
                      _isPressed2 = true;
                    });
                  },
                  onTapUp: (details) {
                    setState(() {
                      _isPressed2 = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExpenseHomePage(fullname: dataOfUser['name'].toString())),
                    );
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 5000),
                    curve: Curves.easeOut,
                    child: Transform.translate(
                      offset: Offset(0, _isPressed2 ? 10 : 0),
                      child: Icon2(), 
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text('Expenses', style: TextStyle(color: Colors.white)),
              ],
            ),
                        Column(
              children: [
                GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      _isPressed3 = true;
                    });
                  },
                  onTapUp: (details) {
                    setState(() {
                      _isPressed3 = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Medications()),
                    );
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeOut,
                    child: Transform.translate(
                      offset: Offset(0, _isPressed3 ? 10 : 0),
                      child: Icon3(), 
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text('SOS', style: TextStyle(color: Colors.white)),
              ],
            ),
                Column(
              children: [
                GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      _isPressed4 = true;
                    });
                  },
                  onTapUp: (details) {
                    setState(() {
                      _isPressed4 = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountScreen()),
                    );
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 5000),
                    curve: Curves.easeOut,
                    child: Transform.translate(
                      offset: Offset(0, _isPressed4 ? 10 : 0),
                      child: Icon4(), 
                    ),
                  ),
                ),
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
                            GestureDetector(
 onTapDown: (details) {
    setState(() {
      _isPressedB1 = true;
    });
  },
  onTapUp: (details) async { // Make this callback async
    setState(() {
      _isPressedB1 = false;
    });
    String globalPin = await getGlobalPin(); // Get the global pin
    print("GLOBAL PIN IS ${globalPin}");
    if (globalPin == '000') { 
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please go to settings and set the mode pin.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ElderPage()),
      );
    }
  },
  child: AnimatedContainer(
    duration: Duration(milliseconds: 200),
    curve: Curves.easeOut,
    child: Transform.translate(
      offset: Offset(0, _isPressedB1 ? 10 : 0),
      child: Card(
        elevation: _isPressedB1 ? 0 : 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.0),
          child: FunctionTile(
            icon: Icons.switch_account,
            functionName: 'Switch Mode',
            functionSub: 'Elder Friendly Interface',
            color: Colors.lime[300],
          ),
        ),
      ),
    ),
  ),
),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
  onTapDown: (details) {
    setState(() {
      _isPressedB2 = true;
    });
  },
  onTapUp: (details) {
    setState(() {
      _isPressedB2 = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  },
  child: Transform.translate(
    offset: Offset(0, _isPressedB2 ? 10 : 0),
    child: Card(
      elevation: _isPressedB2 ? 0 : 3.0,
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
),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
  onTapDown: (details) {
    setState(() {
      _isPressedB3 = true;
    });
  },
  onTapUp: (details) {
    setState(() {
      _isPressedB3 = false;
    });
    Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => graphs()),
  (Route<dynamic> route) => false,
);
  },
  child: Transform.translate(
    offset: Offset(0, _isPressedB3 ? 10 : 0),
    child: Card(
      elevation: _isPressedB3 ? 0 : 3.0,
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
),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
  onTapDown: (details) {
    setState(() {
      _isPressedB4 = true;
    });
  },
  onTapUp: (details) {
    setState(() {
      _isPressedB4 = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  },
  child: Transform.translate(
    offset: Offset(0, _isPressedB4 ? 10 : 0),
    child: Card(
      elevation: _isPressedB4 ? 0 : 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.0),
        child: FunctionTile(
          icon: Icons.mark_chat_unread_rounded,
          functionName: 'Communities',
          functionSub: 'Interact with people',
          color: Colors.purple[300],
        ),
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
