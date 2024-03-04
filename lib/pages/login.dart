import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:theog/pages/home_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:theog/data_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // int _currentIndex = 0;
  final List<String> images = [
    'assets/landing/image1.jpg',
    'assets/landing/image2.jpg',
    'assets/landing/image3.jpg',
  ];

  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _showInvalidNumberPopup(String message, String error) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
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

  sendOtp(String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/send_otp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'phone_number': phoneNumber}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Check if 'error' is not null before accessing its properties
        if (responseData['error'] != null) {
          _showInvalidNumberPopup(
              responseData['message'], responseData['error']);
        } else {
          // Provider.of<PhoneNumberProvider>(context, listen: false).phoneNumber =
          //     phoneNumber;
          Navigator.pushNamed(
            context,
            '/otp',
            arguments: {
              'phoneNumber': phoneNumber,
              'receivedOtp': responseData['otp'],
            },
          );
        }
      } else {
        print('Failed to send OTP. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error sending OTP: $e');
      _showInvalidNumberPopup(
        'Failed to send OTP. Please try again later.',
        'SERVER_ERROR',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/landing/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(12, 12, 12, 0.7),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: [
              Container(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                          hphoneNumber: 'Guest Number',
                          hfullname: 'Guest',
                          hposition: 'Guest',
                          hparty: 'Guest Party',
                          hlokhsabha: 'Guest Lokhsabha',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Icon(
                          LineAwesomeIcons.fast_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.43),
            Container(
              padding: EdgeInsets.all(20.0),
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
                          style: TextStyle(color: Colors.white),
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
                              color: Colors.grey,
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            sendOtp(_phoneNumberController.text);
                          } else {
                            _showInvalidNumberPopup(
                              'Please enter a valid 10-digit phone number.',
                              'INVALID_NUMBER',
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
