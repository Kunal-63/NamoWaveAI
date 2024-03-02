import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:theog/pages/HomeScreenWidget.dart';
import 'package:theog/pages/SearchScreenWidget.dart';
import 'package:theog/pages/ProfileScreenWidget.dart';

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
    'assets/home/image1.jpg',
    'assets/home/image2.jpg',
    'assets/home/image3.jpg',
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 0.7),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              images[_currentIndex],
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              GNav(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                activeColor: Colors.white,
                backgroundColor: Color.fromRGBO(12, 12, 12, 0.9),
                color: Colors.white,
                tabBackgroundColor: Colors.grey[700]!,
                tabMargin: EdgeInsets.all(5),
                gap: 8,
                onTabChange: (value) {
                  setState(() {
                    _selectedIndex = value;
                    _currentIndex = value;
                  });
                },
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
