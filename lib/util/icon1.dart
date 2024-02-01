import 'package:flutter/material.dart';

class Icon1 extends StatelessWidget {
  const Icon1 ({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
        
        elevation: 5.0, // Change this value to adjust the elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Change this value to change the border radius
        ),
    // padding: EdgeInsets.all(16),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Icon(
        Icons.bubble_chart_rounded, 
        color: Colors.blue[600],
        size: 30,
        
      )),
    ),

    );
}

}