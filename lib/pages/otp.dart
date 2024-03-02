import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  // Function to handle OTP verification
  void verifyOtp(String enteredOtp, String receivedOtp, BuildContext context) {
    if (receivedOtp == enteredOtp) {
      Navigator.pushReplacementNamed(context, '/register');
    } else {
      showInvalidOtpSnackBar(context);
    }
  }

  // Function to show SnackBar for invalid OTP
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
      final response = await http.post(
        Uri.parse('http://192.168.0.38:8000/resend_otp'),
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

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/otp/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(12, 12, 12, 0.9),
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
                  child: const Text(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
