import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medtrack/Medicins/newMed.dart';
import 'package:medtrack/graphs.dart';
import 'package:medtrack/historyCard.dart';
import 'package:medtrack/homePage.dart';
import 'package:medtrack/newCard.dart';
import 'package:medtrack/pages/dash.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/intl.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

class History extends StatefulWidget {
  @override
  State<History> createState() => _HistoryState();
}

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
bool showSpinner = false;

List<dynamic> dataOfTakedMed = [];

Map<String, Color> _Colors = {
   "orange": Color.fromARGB(255, 241, 135, 128),
    "blue": Color.fromARGB(255, 165, 238, 171)
};

class _HistoryState extends State<History> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  User? user = _auth.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    getTheTakedMedicines();
    super.initState();
  }

  Future<void> getTheTakedMedicines() async {
    setState(() {
      showSpinner = true;
    });
    dataOfTakedMed = [];
    await FirebaseFirestore.instance
        .collection('Taked')
        .where('usermail', isEqualTo: _auth.currentUser!.email).where('taked',isEqualTo: true)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        dataOfTakedMed.add(doc.data());
      });
      dataOfTakedMed.sort((a, b) => b["medDate"].compareTo(a["medDate"]));
      dataOfTakedMed.sort((a, b) => b["takedAt"].compareTo(a["takedAt"]));
      print(dataOfTakedMed[1]);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Color.fromARGB(255, 255, 255, 255),
  appBar: PreferredSize(
    preferredSize: Size.fromHeight(70),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue[600],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('History',
          style: TextStyle(
          
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
         centerTitle: true,
      ),
    ),
  ),
  body: ModalProgressHUD(
    inAsyncCall: showSpinner,
    child: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: dataOfTakedMed.length,
            itemBuilder: (BuildContext context, int index) {
              return HistoryCard(dataOfTakedMed[index]);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ],
    ),
  ),
);
  }
}