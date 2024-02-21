import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AboutPage extends StatelessWidget {
  Future<int> calculateCacheSize() async {
    try {
      Directory cacheDir = await getTemporaryDirectory();
      return await _getDirectorySize(cacheDir);
    } catch (e) {
      print('Error calculating cache size: $e');
      return 0; // Return 0 in case of any error
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
            appBar: AppBar(
              title: Text('About My App'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info, size: 50 * textScaleFactor),
                  Text('My App', style: TextStyle(fontSize: 24 * textScaleFactor)), // Hardcoded app name
                  Text('Version: 1.0.0', style: TextStyle(fontSize: 16 * textScaleFactor)), // Hardcoded version
                  // Text('Cache Size: ${cacheSizeInMB.toStringAsFixed(2)} MB', style: TextStyle(fontSize: 16 * textScaleFactor)),
                  // Text('App Size: 93MB', style: TextStyle(fontSize: 16 * textScaleFactor)),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      'A brief description about your app and its features.',
                      style: TextStyle(fontSize: 16 * textScaleFactor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text('© ${DateTime.now().year} My App. All rights reserved.', style: TextStyle(fontSize: 16 * textScaleFactor)),
                ],
              ),
            ),
          );
        } else {
          // Loading or error state
          return Scaffold(
            appBar: AppBar(
              title: Text('About My App'),
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