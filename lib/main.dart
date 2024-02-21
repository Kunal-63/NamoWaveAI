import 'package:flutter/material.dart';
import 'package:theog/pages/landing_screen.dart';
import 'package:theog/pages/login.dart';
import 'package:theog/pages/profile.dart';
import 'package:theog/pages/register_screen.dart';
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
        '/': (context) => AnimatedSplash(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}

class AnimatedSplash extends StatefulWidget {
  @override
  _AnimatedSplashState createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash> {
  final String splashText = 'MobileOrlovAI';

  String _currentText = '';

  @override
  void initState() {
    super.initState();

    _animateText();
  }

  Future<void> _animateText() async {
    for (int i = 0; i <= splashText.length; i++) {
      setState(() {
        _currentText = splashText.substring(0, i);
      });
      await Future.delayed(
          Duration(milliseconds: 100)); // Adjust the delay as needed
    }

    // Navigate to the main screen when text animation completes
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LandingScreen(), // Your main screen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange, // Set the background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 200.0,
              width: 200.0,
            ),
            const SizedBox(height: 20.0),
            Text(
              _currentText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
