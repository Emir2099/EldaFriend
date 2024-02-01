import 'package:flutter/material.dart';

class FunctionTile extends StatelessWidget {
  final icon;
  final String functionName;
  final String functionSub;
  final color;

  const FunctionTile({ 
    Key? key,
    required this.icon,
    required this.functionName,
    required this.functionSub,
    required this.color,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)
                            ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                 child: 
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child:Icon(
                                    icon,
                                    color: Colors.white,
                                  ),
                                  color: color,
      
                                ),
                                  ),
                                SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(functionName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(functionSub,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              ),
                                Icon(Icons.more_horiz),
                              ],
                              ),
                          
                          ),
    );
}
}