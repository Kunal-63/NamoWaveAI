import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(LineAwesomeIcons.angle_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Login',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: 'Email',
                    hintText: 'Enter your email or phone no',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.orange)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: 'Password',
                    suffixIcon: Icon(LineAwesomeIcons.eye),
                    suffixIconColor: Colors.black,
                    hintText: 'Enter your password',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.orange)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {},
                  child: Text('Sign in'),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Container(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Container(
                child: TextButton(
                  onPressed: () {},
                  child: Text('New to MobileOrlovAI? Sign up now.',
                      style: TextStyle(color: Colors.orange)),
                ),
              ),
            ),
          ],
        ));
  }
}
