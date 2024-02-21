import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medtrack/screens/main_settings_screen.dart';
import 'package:path_provider/path_provider.dart';

class AboutPage extends StatelessWidget {
  Future<int> calculateCacheSize() async {
    try {
      Directory cacheDir = await getTemporaryDirectory();
      return await _getDirectorySize(cacheDir);
    } catch (e) {
      print('Error calculating cache size: $e');
      return 0;
    }
  }

  Future<int> _getDirectorySize(Directory dir) async {
    int size = 0;
    await for (FileSystemEntity entity in dir.list(recursive: true)) {
      if (entity is File) {
        size += await entity.length();
      }
    }
    return size;
  }

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return FutureBuilder<int>(
      future: calculateCacheSize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          int cacheSizeInBytes = snapshot.data ?? 0;
          double cacheSizeInMB = cacheSizeInBytes / (1024 * 1024);

          return Scaffold(
            backgroundColor: Colors.white,
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
              MaterialPageRoute(builder: (context) =>AccountScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('About',
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
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('screenShots/about_logo.png'), // Replace with your app logo asset
                  ),
                  SizedBox(height: 20),
                  Text('EldaFriend', style: TextStyle(fontSize: 24 * textScaleFactor, fontWeight: FontWeight.bold)), // Hardcoded app name
                  Text('Version: 1.0.0', style: TextStyle(fontSize: 16 * textScaleFactor, color: Colors.blue[800])), // Hardcoded version
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      'An application for your loved ones',
                      style: TextStyle(fontSize: 16 * textScaleFactor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text('© ${DateTime.now().year} EldaFriend. All rights reserved.', style: TextStyle(fontSize: 16 * textScaleFactor, color: Colors.blue[800])),
                ],
              ),
            ),
          );
        } else {
          // Loading or error state
          return Scaffold(
            appBar: AppBar(
              title: Text('About My App'),
              backgroundColor: Colors.blue[800],
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}