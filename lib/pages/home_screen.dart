import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:theog/pages/HomeScreenWidget.dart';
import 'package:theog/pages/ProfileScreenWidget.dart';
import 'package:theog/pages/SearchScreenWidget.dart';

// import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = [
    HomeScreenWidget(),
    SearchScreen(),
    ProfileScreen(),
  ];

  static List<String> images = [
    'assets/landing1.png',
    'assets/landing2.png',
    'assets/landing3.png',
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: GNav(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          backgroundColor: Colors.transparent,
          activeColor: Colors.white,
          color: Colors.white,
          tabBackgroundColor: Colors.grey[700]!,
          tabMargin: EdgeInsets.all(5),
          gap: 8,
          onTabChange: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          iconSize: 24,
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
        ));
  }
}
