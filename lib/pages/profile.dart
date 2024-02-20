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
            icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
