import 'package:flutter/material.dart';
import 'package:theog/pages/login.dart';
import 'package:theog/pages/otp.dart';

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
        '/otp': (context) => OtpScreen(),
      },
    );
  }
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

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
        builder: (context) => LoginScreen(), // Your main screen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/splash/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor:
            Color.fromRGBO(12, 12, 12, 1), // Set the background color
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
            ],
          ),
        ),
      ),
    );
  }
}