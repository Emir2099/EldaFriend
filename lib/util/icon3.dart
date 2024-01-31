import 'package:flutter/material.dart';

class Icon3 extends StatelessWidget {
  const Icon3 ({ Key? key}) : super(key: key);

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
      Icons.sos, 
      color: Colors.white,
      size: 30,
      
    )),

    );
}

}