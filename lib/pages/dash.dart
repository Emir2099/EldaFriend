import 'package:flutter/material.dart';

class DashPage extends StatefulWidget {
  const DashPage({super.key});

  @override
  State<DashPage> createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
      child:Column(
        children: [
        Row(
          children: [
          //Hi
          Text('Hi Emir!',
          style: TextStyle(color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          ),
          ), 
          //Notify
        ],)
      ]),
      ),
    );
  }
}