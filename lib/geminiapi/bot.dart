//GEMINI API
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart'; // Add this line to import the 'get' package
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'gemini_api.dart';
bool isButtonPressed = false;
final promptController = TextEditingController();
final focusNode = FocusNode();

class BotHome extends StatefulWidget {
  const BotHome({Key? key}) : super(key: key);

  @override
  _BotHomeState createState() => _BotHomeState();
}


const _backgroundColor = Color.fromARGB(255, 255, 255, 255);
const  _colors = [
    Color.fromARGB(255, 121, 215, 243),
    Colors.blue,
];

const _durations = [
    5000,
    4000,
];

const _heightPercentages = [
    0.40,
    0.41,
];
class _BotHomeState extends State<BotHome> {
  final textController = TextEditingController();
  final result = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  const Text(
                    'Gemini BOT',
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
                      'Enter your query',
                      style: TextStyle(color: Colors.blue[100]),
                    ),
                  ],
                ),
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
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: textController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: 
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.blueGrey; // the color when button is pressed
          }
          return isButtonPressed ? Colors.grey : Colors.white; // default color
                },
              ),
            ),
            onPressed: () async {
              setState(() {
                isButtonPressed = true;
              });
              result.value = await GeminiAPI.getGeminiData(textController.text);
              setState(() {
                isButtonPressed = false;
              });
            },
            child: Text(
              'Generate',
              style: TextStyle(color: Colors.black),
            ),
          ),
              ),
              SizedBox(
                height: 25,
              ),
             Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
                ),
              ),
              padding: EdgeInsets.all(25),
              child: Center(
                child: Obx(
          () => isButtonPressed ? Container(
                  height: 80,
                      width: 80,
                  child: Card(
                    elevation: 12.0,
                        margin:const  EdgeInsets.only(
                            right: 10, left: 10, bottom: 16.0),
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(500.0),
                        ),
                
                    child: WaveWidget(
                    config: CustomConfig(
                        colors: _colors,
                        durations: _durations,
                        heightPercentages: _heightPercentages,
                    ),
                    backgroundColor: _backgroundColor,
                    // size: (double.infinity, double.infinity),
                    size: Size(double.infinity, double.infinity),
                    waveAmplitude: 5,
                                  ),
                  ),
                ):
          SingleChildScrollView(
            child: Text(
              result.value,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black),
            ),
          ),
                ),
              ),
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}