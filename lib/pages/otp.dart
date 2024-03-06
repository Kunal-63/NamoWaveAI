import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:theog/pages/home_screen.dart';
import 'package:theog/pages/register_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _isLoading = false;
  // Function to handle OTP verification
  void showInvalidOtpSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Invalid OTP"),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.grey[700],
        elevation: 6,
      ),
    );
  }

  // Function to resend OTP
  Future<void> resendOtp(String phoneNumber, BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });

      final response = await http.post(
        Uri.parse('http://192.168.1.8:8000/resend_otp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'phone_number': phoneNumber}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Navigator.pushReplacementNamed(
          context,
          '/otp',
          arguments: {
            'phoneNumber': phoneNumber,
            'receivedOtp': responseData['otp'],
          },
        );
      } else {
        print('Failed to resend OTP. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error resending OTP: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String phoneNumber = arguments['phoneNumber'];
    final String receivedOtp = arguments['receivedOtp'];
    final String enteredOtp = '';

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    Future<void> DataVerifyingInSQL(String phoneNumber) async {
      final response = await http.post(
        Uri.parse('http://192.168.1.8:8000/verify_otp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'phone_number': phoneNumber}),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        if (responseData['message'] == 'user found') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        hphoneNumber: phoneNumber,
                        hfullname: responseData['fullname'],
                        hposition: responseData['position'],
                        hparty: responseData['party'],
                        hlokhsabha: responseData['lokhsabha'],
                        profileURL: responseData['profile_url'],
                      )));
          return;
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => RegisterScreen(
                        title: '',
                        phoneNumber: phoneNumber,
                      )));
        }
      } else {
        print('Failed to verify OTP. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    }

    void verifyOtp(
        String enteredOtp, String receivedOtp, BuildContext context) {
      if (receivedOtp == enteredOtp) {
        DataVerifyingInSQL(phoneNumber);
      } else {
        showInvalidOtpSnackBar(context);
      }
    }

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/otp/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(12, 12, 12, 0.7),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            width: double.infinity,
            child: Column(
              children: [
                Image.asset('assets/otp.gif', height: 200, width: 200),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Text(
                    "+91 $phoneNumber",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Pinput(
                  length: 6,
                  controller: TextEditingController(
                    text: enteredOtp,
                  ),
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  onCompleted: (pin) => verifyOtp(pin, receivedOtp, context),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () async {
                    await resendOtp(phoneNumber, context);
                  },
                  child: const Text(
                    "Resend OTP",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    verifyOtp(enteredOtp, receivedOtp, context);
                  },
                  child: _isLoading
                      ? CircularProgressIndicator() // Show loading indicator
                      : const Text(
                          "Verify",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                if (_isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
