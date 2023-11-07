import 'package:flutter/material.dart';
import '../screens/start_page.dart';
import '../screens/login_register_page.dart';
import '../screens/login_page.dart';
import '../screens/register_auth_page.dart';
import '../screens/register_input_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterInputPage(username: "김민석"),
    );
  }
}
