import 'package:api_testing/home_screen.dart';
import 'package:api_testing/screen_five.dart';
import 'package:api_testing/screen_four.dart';
import 'package:api_testing/screen_three.dart';
import 'package:api_testing/screen_two.dart';
import 'package:api_testing/signup.dart';
import 'package:api_testing/upload_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: const UploadImage(),
    );
  }
}
