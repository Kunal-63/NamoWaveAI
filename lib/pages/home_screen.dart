import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300]!,
          elevation: 0.0,
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
          ],
        ),
        body: const Center(
          child: Text('Home Screen'),
        ),
        bottomNavigationBar: GNav(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          backgroundColor: Colors.blue[300]!,
          activeColor: Colors.black,
          color: Colors.white,
          tabBackgroundColor: Colors.blue[100]!,
          tabMargin: EdgeInsets.all(5),
          gap: 8,
          onTabChange: (value) {
            if (value == 2) {
              Navigator.pushNamed(context, '/profile');
            }
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
