import 'package:flutter/material.dart';
import 'package:lamie_middle_east_machine_task/view/screen_home.dart';
import 'package:lamie_middle_east_machine_task/view/screen_login.dart';
import 'package:lamie_middle_east_machine_task/view/screen_sign_up.dart';
import 'package:lamie_middle_east_machine_task/view/screen_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenHome(),
    );
  }
}
