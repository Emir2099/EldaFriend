import 'dart:convert';
//import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medtrack/settingsSOS.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class updateSOS extends StatefulWidget {
  static Map<String, field_w> numbers = {
    'Doctor': field_w("Doctor"),
    'Family': field_w("Family"),
  };
  updateSOS();
  @override
  State<updateSOS> createState() => _updateSOSState();
}

bool showSpinner = false;
Map<String, Color> _Colors = {
  "orange": Color.fromARGB(255, 231, 146, 71),
  "blue": Color.fromARGB(255, 92, 107, 192)
};

class _updateSOSState extends State<updateSOS> {
  // updateSOS temp = new updateSOS();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  void _update_widget(String key) {}
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
                MaterialPageRoute(builder: (context) => settingsSOS()),
                (Route<dynamic> route) => false,
              );
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Set Up SOS',
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
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          height: 1000,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              for (var element in updateSOS.numbers.keys) ...[
                updateSOS.numbers[element.toString()] as Widget,
              ],
            ],
          ),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton( // Add the FloatingActionButton
      backgroundColor: Colors.blue[600],
      onPressed: () {
        setState(() {
          updateSOS.numbers['phone' +
              (updateSOS.numbers.length + 2)
                  .toString()] = field_w(
              'phone ' + (updateSOS.numbers.length + 1).toString());
        });
      },
      child: Icon(
          Icons.add,
          size: 30,
        ),
    ),
  );
}
}

class field_w extends StatefulWidget {
  final String name;
  var phone = "";
  field_w(this.name);

  @override
  State<field_w> createState() => _field_wState();

  getphone() {
    return phone;
  }

  void setphone(var p) {
    this.phone = p;
  }

  String getname() {
    return name;
  }
}

class _field_wState extends State<field_w> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns the children along the start (left for LTR languages)
      children: [
        Text(widget.name + ": ", style: TextStyle(fontSize: 20)),
        SizedBox(
          height: 10, // Adds some space between the Text and TextFormField
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.09,
          child: TextFormField(
            initialValue: widget.phone,
            onChanged: (value) {
              setState(() {
                widget.phone = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15), // Rounded corners
                borderSide: BorderSide(
                  color: Colors.blue, // Border color
                  width: 2, // Border width
                ),
              ),
              fillColor: Color.fromARGB(255, 255, 255, 255),
              filled: true,
              hintText: 'Enter Number', // Placeholder text
              hintStyle: TextStyle(color: Colors.grey), // Placeholder text style
              contentPadding: EdgeInsets.all(10), // Inner padding
            ),
          ),
        ),
      ],
    );
  }
}