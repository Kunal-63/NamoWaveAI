import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _currentIndex = 0;
  final List<String> images = [
    'assets/login1.png',
    'assets/login2.png',
    'assets/login3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Expanded(
            child: CarouselSlider.builder(
              itemCount: images.length,
              options: CarouselOptions(
                height: double.infinity,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                autoPlay: true,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Positioned(
              top: 20,
              right: 10,
              child: TextButton(
                child: Text(
                  'Skip Login >',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.underline),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              )),
          Positioned(
              bottom: MediaQuery.of(context).size.height / 3.5,
              left: 20.0,
              right: 20.0,
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Log in or sign up to continue',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            fillColor: Color.fromRGBO(100, 100, 100, 0.5),
                            filled: true,
                            // prefix: Icon(Icons.phone),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            hintText: 'Enter phone number without +91',
                            hintStyle: TextStyle(
                              color: Colors.grey[300],
                            ),
                            labelText: 'Phone',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            helperText:
                                "we'll send you an OTP by SMS to confirm your number",
                            helperStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/otp');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Get OTP',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                          ),
                        ),
                      ),
                    ]),
              )),
        ],
      ),
    );
  }
}
