import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(),
        bottomNavigationBar: GNav(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          backgroundColor: Colors.blue[300]!,
          activeColor: Colors.black,
          color: Colors.white,
          tabBackgroundColor: Colors.blue[100]!,
          tabMargin: EdgeInsets.all(5),
          gap: 8,
          onTabChange: (value) {
            if (value == 0) {
              Navigator.pushNamed(context, '/home');
            }
            if (value == 1) {
              Navigator.pushNamed(context, '/search');
            }
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
