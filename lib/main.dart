import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theog/pages/home_screen.dart';
import 'package:theog/pages/login.dart';
import 'package:theog/pages/otp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool firstTimeLogin = prefs.getBool('firstTimeLogin') ?? true;
  runApp(MyApp(
    firstTimeLogin: firstTimeLogin,
  ));
}

class MyApp extends StatelessWidget {
  final bool firstTimeLogin;
  const MyApp({super.key, required this.firstTimeLogin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => AnimatedSplash(
              firstTimeLogin: firstTimeLogin,
            ),
        '/login': (context) => LoginScreen(),
        '/otp': (context) => OtpScreen(),
      },
    );
  }
}

class AnimatedSplash extends StatefulWidget {
  final bool firstTimeLogin;
  const AnimatedSplash({Key? key, required this.firstTimeLogin})
      : super(key: key);
  @override
  _AnimatedSplashState createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash> {
  final String splashText = 'MobileOrlovAI';
  String _currentText = '';

  late String userPhoneNumber;
  late String userFullName;
  late String userPosition;
  late String userParty;
  late String userLokSabha;
  late String userVidhanSabha;
  late String userProfileURL;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _animateText();
    await _getUserData();

    // Navigate to the main screen when text animation completes
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => widget.firstTimeLogin
            ? LoginScreen()
            : HomeScreen(
                hphoneNumber: userPhoneNumber,
                hposition: userPosition,
                hfullname: userFullName,
                hparty: userParty,
                hlokhsabha: userLokSabha,
                hvidhansabha: userVidhanSabha,
                profileURL: userProfileURL,
              ),
      ),
    );
  }

  Future<void> _animateText() async {
    for (int i = 0; i <= splashText.length; i++) {
      setState(() {
        _currentText = splashText.substring(0, i);
      });
      await Future.delayed(
          Duration(milliseconds: 100)); // Adjust the delay as needed
    }
  }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userPhoneNumber = prefs.getString('userPhoneNumber') ?? '';
    userFullName = prefs.getString('userFullName') ?? '';
    userPosition = prefs.getString('userPosition') ?? '';
    userParty = prefs.getString('userParty') ?? '';
    userLokSabha = prefs.getString('userLokSabha') ?? '';
    userVidhanSabha = prefs.getString('userVidhanSabha') ?? '';
    userProfileURL = prefs.getString('userProfileURL') ?? '';
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
              ClipOval(
                child: Image.asset(
                  'assets/logo.png',
                  height: 200.0,
                  width: 200.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
