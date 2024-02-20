import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Icon(LineAwesomeIcons.angle_left,
              color: isDark ? Colors.white : Colors.black),
          title: const Center(child: const Text('Profile')),
          actions: [
            IconButton(
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
                  color: isDark ? Colors.white : Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage: AssetImage('assets/dummy.jpg'),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Theo Githinji',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Mobile Developer',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Theo Githinji',
                    labelText: 'President',
                    labelStyle: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    hintStyle: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    prefixIcon: Icon(
                      LineAwesomeIcons.suitcase,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
