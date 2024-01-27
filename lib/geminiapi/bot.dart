//GEMINI API
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart'; // Add this line to import the 'get' package

import 'gemini_api.dart';

final promptController = TextEditingController();
final focusNode = FocusNode();

class Bot extends StatefulWidget {
  const Bot({Key? key}) : super(key: key);

  @override
  State<Bot> createState() => _BotState();
}

class _BotState extends State<Bot> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BotHome(),
    );
  }
}

class BotHome extends StatefulWidget {
  const BotHome({Key? key}) : super(key: key);

  @override
  _BotHomeState createState() => _BotHomeState();
}

class _BotHomeState extends State<BotHome> {
  final textController = TextEditingController();
  final result = ''.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                keyboardType: TextInputType.text,
                controller: textController,
              ),
              const SizedBox(height: 20),
              EditableText(
                controller: promptController,
                focusNode: focusNode,
                style: TextStyle(color: Colors.black),
                backgroundCursorColor: Colors.black,
                cursorColor: Colors.black,
              ), // Add this line
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  result.value =
                      await GeminiAPI.getGeminiData(textController.text);
                },
                child: const Text('Generate',
                    style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(height: 20),
              Obx(() => Text(result.value,
                  style: const TextStyle(
                      color: Colors
                          .black))), // Add this line to use the 'Obx' method
            ],
          ),
        ),
      ),
    );
  }
}
