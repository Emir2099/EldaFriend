import 'package:flutter/material.dart';

class Icon2 extends StatelessWidget {
  const Icon2 ({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[600],
        borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.all(16),
    child: Center(
      child: Icon(
      Icons.timer, 
      color: Colors.white,
      size: 30,
      
    )),

    );
}

}