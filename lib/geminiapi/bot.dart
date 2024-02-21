//GEMINI API
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart'; // Add this line to import the 'get' package
import 'package:medtrack/geminiapi/consts.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'gemini_api.dart';
bool isButtonPressed = false;
final promptController = TextEditingController();
final focusNode = FocusNode();
bool speaking = false;

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
    var screenSize = MediaQuery.of(context).size;
    var paddingValue = screenSize.width * 0.05; // 5% of screen width
    var buttonWidth = screenSize.width * 0.9; // 90% of screen width
    var buttonHeight = screenSize.height * 0.08; // 8% of screen height
    return Scaffold(
      backgroundColor: Colors.blue[800],
      floatingActionButton:speaking? FloatingActionButton(
        child: Icon(Icons.volume_off),
        // style: ElevatedButton.styleFrom(
        //   backgroundColor: Colors.blue[300], // This needed to be fixed
        // ),
        backgroundColor: Colors.blue[300],
        onPressed: () async {
          await stopSpeaking();
          setState(() {
            speaking = false;
          });
        }
      ): null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: paddingValue),
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
                      height: paddingValue,
                    ),
                    Text(
                      'Enter your query',
                      style: TextStyle(color: Colors.blue[100]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: paddingValue,
              ),
              Padding(
                padding: EdgeInsets.only(left: paddingValue, right: paddingValue),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(paddingValue),
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
                height: paddingValue,
              ),
              
              Padding(
                padding: EdgeInsets.only(left: paddingValue, right: paddingValue),
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
              result.value = (await GeminiAPI.getGeminiData(textController.text)).replaceAll(RegExp(r'\*'), '');
              speaking = true;
              await fetchAndSpeak(result.value);
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
                height: paddingValue,
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
              padding: EdgeInsets.all(paddingValue),
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
          Stack(
  children: [
    Positioned(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              result.value,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            
          ],
        ),
      ),
    ),
    
  ],
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