import 'package:flutter/material.dart';

class Icon3 extends StatelessWidget {
  const Icon3 ({ Key? key}) : super(key: key);

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
        Icons.sos, 
        color: Colors.blue[600],
        size: 30,
        
      )),
    ),

    );
}

}