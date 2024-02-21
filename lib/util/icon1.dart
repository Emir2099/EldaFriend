import 'package:flutter/material.dart';

class Icon1 extends StatelessWidget {
  const Icon1 ({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
        elevation: 5.0, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), 
        ),
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