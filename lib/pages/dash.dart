import 'package:flutter/material.dart';
import 'package:medtrack/util/functions_tile.dart';
import 'package:medtrack/util/icon1.dart';
import 'package:medtrack/util/icon2.dart';
import 'package:medtrack/util/icon3.dart';
import 'package:medtrack/util/icon4.dart';
import 'package:flutter/src/material/list_tile.dart';

class DashPage extends StatefulWidget {
  const DashPage({Key? key}) : super(key: key);

  @override
  State<DashPage> createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: SizedBox(
      //         width: 24,
      //         child: Icon(Icons.home, color: Colors.blue), // Set default color here
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SizedBox(
      //         width: 24,
      //         child: Icon(Icons.calendar_today, color: Colors.blue), // Set default color here
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SizedBox(
      //         width: 24,
      //         child: Icon(Icons.person, color: Colors.blue), // Set default color here
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SizedBox(
      //         width: 24,
      //         child: Icon(Icons.settings, color: Colors.blue), // Set default color here
      //       ),
      //       label: '',
      //     ),
      //   ],
      // ),

      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi Emir!',
                        style: TextStyle(
                          color: Colors.white,
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
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    // child: Container(
                    //   decoration: BoxDecoration(
                    //     color: Colors.blue[600],
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    child: Card(
        
        elevation: 5.0, // Change this value to adjust the elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Change this value to change the border radius
        ),
                      // padding: EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                       color: Colors.blue[600],
                       borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Container(
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
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Row(
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
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon1(),
                    SizedBox(
                      height: 8,
                    ),
                    Text('AI', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Icon2(),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Water Rem.', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Icon3(),
                    SizedBox(
                      height: 8,
                    ),
                    Text('SOS', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Icon4(),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Settings', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                padding: EdgeInsets.all(25),
                // color: Colors.grey[300],
                child: Center(
                  child: Column(
                    children: [
                      // MAIN Functions heading
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                      Text(
                        'Main Functionalities',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                      Icon(Icons.more_horiz),
                        ]
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      // Listview of Main Functions

                      Expanded(
  child: ListView(
    children: [
      InkWell(
      onTap: () {
      
      },
      child: Card(
        
        elevation: 3.0, // Change this value to adjust the elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Change this value to change the border radius
        ),
        // decoration: BoxDecoration(
        //   border: Border.all(
        //     color: Colors.black, // Change this color to change the border color
        //     width: 0.2, // Change this value to change the border width
        //   ),
        //   borderRadius: BorderRadius.circular(12), // Change this value to change the border radius
        child: Padding(
          padding: EdgeInsets.symmetric(vertical:1.0),
          child: FunctionTile(
            icon: Icons.switch_account,
            functionName: 'Switch Mode',
            functionSub: 'Hop to Elder Friendly interface',
            color: Colors.lime[300],
          ),
        ),
      ),
      ),

      SizedBox(
      height: 10,
    ),

    InkWell(
      onTap: () {
      
      },
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical:1.0),
          child: FunctionTile(
            icon: Icons.medication_liquid_rounded,
            functionName: 'Medication Reminder',
            functionSub: 'Set up medicine notifications',
            color: Colors.green[300],
          ),
        ),
      ),
    ),

       SizedBox(
        height: 10,
      ),

      InkWell(
      onTap: () {
      
      },
       child: Card(
        
        elevation: 3.0, // Change this value to adjust the elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Change this value to change the border radius
        ),
      // Container(
      //   decoration: BoxDecoration(
      //     border: Border.all(
      //       color: Colors.black, // Change this color to change the border color
      //       width: 0.2, // Change this value to change the border width
      //     ),
      //     borderRadius: BorderRadius.circular(12), // Change this value to change the border radius
      //   ),
        child: Padding(
         padding: EdgeInsets.symmetric(vertical:1.0),
          child: FunctionTile(
            icon: Icons.insert_chart_outlined_rounded,
            functionName: 'View Reports',
            functionSub: 'Detailed Analytics',
            color: Colors.pink[300],
          ),
        ),
      ),
      ),

       SizedBox(
        height: 10,
      ),

      InkWell(
      onTap: () {
      
      },
       child: Card(
        elevation: 3.0, // Change this value to adjust the elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Change this value to change the border radius
        ),
      // Container(
      //   decoration: BoxDecoration(
      //     border: Border.all(
      //       color: Colors.black, // Change this color to change the border color
      //       width: 0.2, // Change this value to change the border width
      //     ),
      //     borderRadius: BorderRadius.circular(12), // Change this value to change the border radius
      //   ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical:1.0),
          child: FunctionTile(
            icon: Icons.mark_chat_unread_rounded,
            functionName: 'Communities',
            functionSub: 'Interact with people to know more',
            color: Colors.purple[300],
          ),
        ),
       ),
      ),
    ],
  ),
)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
