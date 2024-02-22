import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.blue[300]!,
            elevation: 0.0,
            title: const Text('Profile'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/login1.png',
                      height: 280,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        child: Image.asset(
                      'assets/dummy.jpg',
                      height: 170,
                      width: 200,
                      fit: BoxFit.cover,
                    ))
                  ],
                )
              ],
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
          )),
    );
  }
}
