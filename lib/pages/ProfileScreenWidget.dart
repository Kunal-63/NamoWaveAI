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
          backgroundColor: Color.fromRGBO(18, 18, 18, 1),
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
                            backgroundColor: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: const Text(
                    'Email',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text('kunaladwani1456@gmail.com',
                      style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.email, color: Colors.white),
                ),
                ListTile(
                  title: const Text('Phone',
                      style: TextStyle(color: Colors.white)),
                  subtitle: const Text('1234567890',
                      style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.phone, color: Colors.white),
                ),
                ListTile(
                  title: const Text('Lokhsabha',
                      style: TextStyle(color: Colors.white)),
                  subtitle: const Text('Ahmedabad',
                      style: TextStyle(color: Colors.white)),
                  leading: const Icon(
                    Icons.location_city,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
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
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
