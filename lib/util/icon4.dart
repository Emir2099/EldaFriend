import 'package:flutter/material.dart';

class Icon4 extends StatelessWidget {
  const Icon4 ({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
        
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), 
        ),
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Icon(
        Icons.settings, 
        color: Colors.blue[600],
        size: 30,
        
      )),
    ),

    );
}

}