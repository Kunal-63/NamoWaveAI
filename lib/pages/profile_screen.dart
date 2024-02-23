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
          backgroundColor: Colors.white,
          // appBar: AppBar(
          //   backgroundColor: Colors.blue[300]!,
          //   elevation: 0.0,
          //   title: const Text('Profile'),
          //   actions: [
          //     IconButton(
          //       onPressed: () {},
          //       icon: const Icon(Icons.menu),
          //     ),
          //   ],
          // ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/login1.png',
                      height: 190,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        top: 147.5,
                        child: Container(
                          height: 85,
                          width: 100,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade800,
                            backgroundImage: AssetImage(
                              'assets/sample_photo.png',
                            ),
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'President',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: const Text('Email'),
                  subtitle: const Text('kunaladwani1456@gmail.com'),
                  leading: const Icon(Icons.email),
                ),
                ListTile(
                  title: const Text('Phone'),
                  subtitle: const Text('1234567890'),
                  leading: const Icon(Icons.phone),
                ),
                ListTile(
                  title: const Text('Lokhsabha'),
                  subtitle: const Text('Ahmedabad'),
                  leading: const Icon(Icons.location_city),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
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
          )),
    );
  }
}
