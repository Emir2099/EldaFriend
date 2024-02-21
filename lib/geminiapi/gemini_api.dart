import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class GeminiAPI {
  static Future<Map<String, String>> getHeader() async {
    return {
      'Content-Type': 'application/json',
    };
  }

  static Future<String> getGeminiData(String message) async {
    try {
      final header = await getHeader();

      final Map<String, dynamic> requestBody = {
        'contents': [
          {
            'parts': [
              {'text': 'user message request here $message'}
            ]
          }
        ],
        'generationConfig': {'temperature': 0.8, 'maxOutputTokens': 1000}
      };

      String url =
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${'AIzaSyCxzhPIu3nAQnpW-eY8YooOQVnT3DhcEhE'}';

      // Use the variables 'header', 'requestBody', and 'url' in code

      // return 'Success'; // Return a meaningful value or result

      var response = await http.post(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(requestBody),
      );
      print(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonResponse['candidates'][0]['content']['parts'][0]['text'];
      } else {
        return '';
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      return '';
    }
  }
}
