import 'package:flutter/material.dart';
import 'package:theog/pages/landing_screen.dart';
import 'package:theog/pages/profile.dart';
// import 'package:tesing/pages/landing_screen.dart';
//
// import 'package:ssip/pages/first.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LandingScreen(),
        '/login': (context) => ProfileScreen(),
      },
    );
  }
}
