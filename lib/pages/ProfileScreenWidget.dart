import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String fullname;
  final String position;
  final String party;
  final String phoneNumber;
  final String lokhsabha;
  const ProfileScreen({
    Key? key,
    required this.fullname,
    required this.position,
    required this.party,
    required this.phoneNumber,
    required this.lokhsabha,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(12, 12, 12, 0.95),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Container(
                  height: 85,
                  width: 100,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                      widget.fullname == "Guest" || widget.fullname == "guest"
                          ? 'assets/images1.png'
                          : 'assets/sample_photo_user.png',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.fullname,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.position,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Column(
                    children: [
                      _buildListTile(
                        title: 'Party',
                        subtitle: widget.party,
                        icon: Icons.flag,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _buildListTile(
                        title: 'Phone',
                        subtitle: widget.phoneNumber,
                        icon: Icons.phone,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _buildListTile(
                        title: 'Lokhsabha',
                        subtitle: widget.lokhsabha,
                        icon: Icons.location_city,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (widget.fullname == "Guest" ||
                        widget.fullname == "guest")
                      _buildButton('Sign In', () {
                        // Sign in button pressed
                      })
                    else ...[
                      _buildButton('Edit Profile', () {
                        // Edit profile button pressed
                      }),
                      _buildButton('Sign Out', () {
                        // Sign out button pressed
                      }),
                    ],
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(icon, color: Colors.white),
        horizontalTitleGap: 0,
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}
