import 'package:flutter/material.dart';

class PhoneNumberProvider with ChangeNotifier {
  String _phoneNumber = '';

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }
}
