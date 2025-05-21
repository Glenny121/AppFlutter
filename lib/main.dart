import 'package:flutter/material.dart';
import 'view/welcome.dart';

void main() {
  runApp(CulturalApp());
}

class CulturalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Centro Cultural UNSA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Welcome(),
    );
  }
}
