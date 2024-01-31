import 'package:flutter/material.dart';
import 'package:medtrack/util/icon1.dart';
import 'package:medtrack/util/icon2.dart';
import 'package:medtrack/util/icon3.dart';
import 'package:medtrack/util/icon4.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(25.0),    
      child:Column(
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          //Hi
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text('Hi Emir!',
          style: TextStyle(color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          ),
          ), 
          SizedBox(
              height: 8,
          ),
          Text(
            '23 Jan, 2024',
            style: TextStyle(color: Colors.blue[100]),
            ),
            ],
          ),
          //Notify
          Container(
          decoration: BoxDecoration(
            color: Colors.blue[600],
            borderRadius: BorderRadius.circular(12),
            ),
          padding: EdgeInsets.all(12),
          child: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          )
        ],
        ),

        SizedBox(
          height: 25,
          ),

          //search bar
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  ),
              ],
            ),
          ),

          SizedBox(
              height: 25,
          ),

            // Base activities
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Text(
              'Base Functionalities',
               style: TextStyle(
                 color: Colors.white,
                 fontSize: 18,
                 fontWeight: FontWeight.bold,
            ),
            ), 
            Icon(
            Icons.more_horiz,
            color: Colors.white,
            ),
            ],
            ),
            SizedBox(
              height: 25,
            ),

            // ICONS

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon1(),
                    
                    SizedBox(
                      height: 8,
                      ),
                      Text(
                        'AI',
                        style: TextStyle(color: Colors.white)
                        ),
              ],
            ),


            Column(
                  children: [
                    Icon2(),
                    
                    SizedBox(
                      height: 8,
                      ),
                      Text(
                        'Water Rem.',
                        style: TextStyle(color: Colors.white)
                        ),
              ],
            ),



            Column(
                  children: [
                    Icon3(),
                    
                    SizedBox(
                      height: 8,
                      ),
                      Text(
                        'SOS',
                        style: TextStyle(color: Colors.white)
                        ),
              ],
            ),



            Column(
                  children: [
                    Icon4(),
                    
                    SizedBox(
                      height: 8,
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(color: Colors.white)
                        ),
              ],
            ),
            ],
          ),
        ],
        ),
      )
      )
    );   
  }
}