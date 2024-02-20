import 'package:medtrack/helper/helper_function.dart';
import 'package:medtrack/homePage.dart';
import 'package:medtrack/openPage.dart';
import 'package:medtrack/pages/about.dart';
import 'package:medtrack/pages/dash.dart';
import 'package:medtrack/pages/help.dart';
import 'package:medtrack/screens/edit_screen.dart';
import 'package:medtrack/servies/auth.dart';
import 'package:medtrack/widgets/forward_button.dart';
import 'package:medtrack/widgets/setting_item.dart';
import 'package:medtrack/widgets/setting_switch.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

String globalPin = '';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkMode = false;
  TextEditingController previousPinController = TextEditingController();
  TextEditingController newPinController = TextEditingController();
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
      preferredSize: Size.fromHeight(70),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[600],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => DashPage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Settings',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
      ),
    ),
      backgroundColor: Colors.blue[600],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 30.0),
              //   child: const Text(
              //     "Settings",
              //     style: TextStyle(
              //       fontSize: 36,
              //       color: Colors.white,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 50),
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SettingItem(
                      title: "About",
                      icon: Ionicons.alert,
                      bgColor: Colors.green.shade100,
                      iconColor: Colors.green,
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutPage(),
                            ),
                          );
                      },
                    ),

//                    SettingItem(
//   title: "Language",
//   icon: Ionicons.earth,
//   bgColor: Colors.orange.shade100,
//   iconColor: Colors.orange,
//   value: this.language,
//   onTap: () {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         String dropdownValue = this.language;
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return AlertDialog(
//               title: Text('Select Language'),
//               content: DropdownButton<String>(
//                 value: dropdownValue,
//                 icon: const Icon(Icons.arrow_downward),
//                 iconSize: 24,
//                 elevation: 16,
//                 style: const TextStyle(color: Colors.deepPurple),
//                 underline: Container(
//                   height: 2,
//                   color: Colors.deepPurpleAccent,
//                 ),
//                 onChanged: (String? newValue) {
//                   Future.delayed(Duration.zero, () {
//   setState(() {
//     dropdownValue = newValue!;
//   });
// });
//                 },
//                 items: <String>[
//                   'English',
//                   'Spanish',
//                   'French',
//                   'German'
//                 ].map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               actions: [
//                 TextButton(
//                   child: Text('OK'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     this.updateLanguage(dropdownValue); // Use the callback function here
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   },
// ),
                    Divider(),
                    const SizedBox(height: 10),
                    SettingItem(
                      title: "Mode Pin",
                      icon: Ionicons.lock_closed_outline,
                      bgColor: Colors.yellow.shade100,
                      iconColor: Colors.yellow,
                      onTap: () {
                        String errorMessage = '';
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return AlertDialog(
                                  title: Text('Enter Pin'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (globalPin != null && globalPin.isNotEmpty)
                                        TextField(
                                          controller: previousPinController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              hintText: "Enter your previous pin"),
                                        ),
                                      TextField(
                                        controller: newPinController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: "Enter your new pin"),
                                      ),
                                      if (errorMessage.isNotEmpty)
                                        Text(
                                          errorMessage,
                                          style: const TextStyle(color: Colors.red),
                                        ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        if (newPinController.text.isEmpty) {
                                          setState(() {
                                            errorMessage = 'This field can\'t be empty';
                                          });
                                        } else if (globalPin != null && previousPinController.text != globalPin) {
                                          setState(() {
                                            errorMessage = 'Previous pin does not match';
                                          });
                                        } else {
                                          globalPin = newPinController.text;
                                          previousPinController.clear();
                                          newPinController.clear();
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    Divider(),
                    const SizedBox(height: 10),
                    SettingItem(
                      title: "Notifications",
                      icon: Ionicons.notifications,
                      bgColor: Colors.blue.shade100,
                      iconColor: Colors.blue,
                      onTap: () {},
                    ),
                    Divider(),
                    const SizedBox(height: 10),
                    SettingItem(
                      title: "Help",
                      icon: Ionicons.help_circle_outline,
                      bgColor: Colors.pink.shade100,
                      iconColor: Colors.pink,
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HelpPage(),
                            ),
                          );
                      },
                    ),
                    Divider(),
                    const SizedBox(height: 10),
                    SettingItem(
                      title: "Log Out",
                      icon: Ionicons.log_out_outline,
                      bgColor: Colors.red.shade100,
                      iconColor: Colors.red,
                      onTap: () {
                        Auth().signoutUser().whenComplete(() async {
                          await HelperFunction.saveUserLoggedInStatusToSharedPreferences(false);
                          await HelperFunction.saveUsernameToSharedPreferences('');
                          await HelperFunction.saveUserEmailToSharedPreferences('');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OpenPage(),
                            ),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _State extends State<StatefulWidget> {
  String language = 'English';

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}