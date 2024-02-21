import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:medtrack/homePage.dart';
import 'package:medtrack/yes_noDialog.dart';
import 'package:medtrack/openPage.dart';

class HistoryCard extends StatefulWidget {
  var dataOfPill;

  HistoryCard(
    this.dataOfPill,
  );
  Map<String, Color> _Colors = {
      "orange": Color.fromARGB(255, 241, 135, 128),
    "blue": Color.fromARGB(255, 165, 238, 171)
  };

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? user = _auth.currentUser;

class _HistoryCardState extends State<HistoryCard> {
  bool taked = false;
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, taked ? 10 : 0),
      child: Card(
        elevation: taked ? 0 : 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Colors.black12, // Border color
                width: 1.0, // Border width
              ),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 255, 255), // First color
                  Color.fromARGB(255, 165, 238, 171) // Second color
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), 
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                  
                    borderRadius: BorderRadius.circular(15.0), 
                    border: Border.all(
                      width: 1.0, 
                    ),
                  ),
                  child: Material(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), 
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image.asset(
                        "assets/images/${widget.dataOfPill['medForm']}.png",
                        width: 50.0, 
                        height: 200.0, 
                      ),
                    ),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.dataOfPill['pillName']
                          .toString()
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '  Take ${widget.dataOfPill['pillAmount']} ${widget.dataOfPill['pillType']}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 87, 87,
                            87), 
                      ),
                    ),
                    Text(
                      '  Taken at ${widget.dataOfPill['takedAt']} \n ${widget.dataOfPill['takedDate']}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 87, 87,
                            87), 
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
