import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        body: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(100, 100, 100, 0.5),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: 'Enter keyword you want to search for',
                      hintStyle: TextStyle(
                        color: Colors.grey[300],
                      ),
                      labelText: 'Search',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
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
