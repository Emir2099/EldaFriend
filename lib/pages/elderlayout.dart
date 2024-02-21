import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medtrack/homePage.dart';
import 'package:medtrack/medications.dart';
import 'package:medtrack/pages/dash.dart';
import 'package:medtrack/screens/main_settings_screen.dart';


const String globalPin = 'globalPin';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? user = _auth.currentUser;

Future<String> getGlobalPin() async {
  final doc = await FirebaseFirestore.instance.collection('users').doc(user!.email).get();
  return doc.get(globalPin);
}

class ElderPage extends StatefulWidget {
  const ElderPage({Key? key}) : super(key: key);

  @override
  State<ElderPage> createState() => _ElderPageState();
}

class _ElderPageState extends State<ElderPage> {
  String title = "Elder Page";

  // Create a Map to hold the color state for each card
  Map<String, Color> cardColors = {
    'Call': Colors.white,
    'Message': Colors.white,
    'Email': Colors.white,
    'Switch Mode': Colors.white, 
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, 
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: [
            _buildCard(Icons.phone, 'Call', context),
            _buildCard(Icons.message, 'Message', context),
            _buildCard(Icons.email, 'Email', context),
            _buildSwitchModeCard(Icons.switch_account, 'Switch Mode', context),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(IconData iconData, String text, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Change color when card is tapped
        setState(() {
          cardColors[text] = Colors.grey;
        });

        // Navigate to a new page based on which card is tapped
        switch (text) {
          case 'Call':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Medications()));
            break;
          case 'Message':
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            break;
          case 'Email':
            Navigator.push(context, MaterialPageRoute(builder: (context) => DashPage()));
            break;
        }

        // Change color back after a short delay
        Future.delayed(Duration(milliseconds: 200), () {
          setState(() {
            cardColors[text] = Colors.white;
          });
        });
      },
      child: Card(
        color: cardColors[text],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 70), // larger icon for better visibility
            Text(text, style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ),
    );
  }
}

class PinDialog extends StatefulWidget {
  final TextEditingController controller;

  PinDialog({required this.controller});

  @override
  _PinDialogState createState() => _PinDialogState();
}

class _PinDialogState extends State<PinDialog> {
  String errorMessage = '';
  String? globalPin;

  @override
  void initState() {
    super.initState();
    fetchGlobalPin();
  }

  Future<void> fetchGlobalPin() async {
    globalPin = await getGlobalPin();
  }

  @override
  Widget build(BuildContext context) {
    print("GLOBAL PIN $globalPin");
    return AlertDialog(
      title: Text('Enter PIN'),
      content: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Enter PIN',
          errorText: errorMessage.isEmpty ? null : errorMessage,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            if (widget.controller.text.isEmpty || widget.controller.text != globalPin) {
              setState(() {
                errorMessage = 'Invalid pin';
              });
            } else {
              Navigator.of(context).pop(widget.controller.text);
            }
          },
        ),
      ],
    );
  }
}
Widget _buildSwitchModeCard(IconData iconData, String text, BuildContext context) {
  return GestureDetector(
    onTap: () async {
      final pin = await _showPinDialog(context);
      String globalPin = await getGlobalPin();
      if (pin != null && pin == globalPin) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashPage()));
      }
    },
    child: Card(
      color:Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, size: 70),
          Text(text, style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
    ),
  );
}

Future<String?> _showPinDialog(BuildContext context) {
  TextEditingController controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (context) {
      return PinDialog(controller: controller);
    },
  );
}