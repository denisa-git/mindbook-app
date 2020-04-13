import 'package:flutter/material.dart';
import 'package:mindbook/home.dart';

class MindbookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mindbook',
      home: HomePage(),
      );
  }
}