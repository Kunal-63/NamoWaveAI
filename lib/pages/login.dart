import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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

  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _showInvalidNumberPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Invalid Number'),
          content: Text('Please enter a valid 10-digit phone number.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(12, 12, 12, 1),
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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                surfaceTintColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                disabledBackgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45.0),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Container(
                child: Row(
                  children: [
                    Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Icon(
                      LineAwesomeIcons.fast_forward,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 3.5,
            left: 20.0,
            right: 20.0,
            child: Form(
              key: _formKey,
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneNumberController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 10) {
                            return 'Please enter a valid 10-digit phone number.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(100, 100, 100, 0.5),
                          filled: true,
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
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, '/otp');
                        } else {
                          _showInvalidNumberPopup();
                        }
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
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
