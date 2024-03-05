import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:theog/pages/home_screen.dart';
import 'crop.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentFullname;
  final String currentParty;
  final String currentPhoneNumber;
  final String currentLokhsabha;
  final String currentPosition;
  final String profileURL;

  const EditProfileScreen(
      {Key? key,
      required this.currentFullname,
      required this.currentParty,
      required this.currentPhoneNumber,
      required this.currentLokhsabha,
      required this.currentPosition,
      required this.profileURL})
      : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _fullnameController;
  late TextEditingController _partyController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _lokhsabhaController;
  late TextEditingController _positionController;

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with current values
    _fullnameController = TextEditingController(text: widget.currentFullname);
    _partyController = TextEditingController(text: widget.currentParty);
    _phoneNumberController =
        TextEditingController(text: widget.currentPhoneNumber);
    _lokhsabhaController = TextEditingController(text: widget.currentLokhsabha);
    _positionController = TextEditingController(text: widget.currentPosition);
  }

  @override
  void dispose() {
    // Dispose text controllers when the widget is disposed
    _fullnameController.dispose();
    _partyController.dispose();
    _phoneNumberController.dispose();
    _lokhsabhaController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  CroppedFile? _croppedFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/registration/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: Color.fromRGBO(12, 12, 12, 0.95),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildTextField('Full Name', _fullnameController),
                SizedBox(height: 10),
                _buildTextField('Party', _partyController),
                SizedBox(height: 10),
                _buildTextField('Phone Number', _phoneNumberController),
                SizedBox(height: 10),
                _buildTextField('Lokhsabha', _lokhsabhaController),
                SizedBox(height: 10),
                _buildTextField('Position', _positionController),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Save changes logic
                    _saveChanges();
                  },
                  child: Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Save changes logic
                    _changeProfile();
                  },
                  child: Text(
                    'Change Profile',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
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

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          maxLines: 1,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    Navigator.pop(context);
    _sendDataToFastAPI();
  }

  void _changeProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CropPage(
          fullname: _fullnameController.text,
          party: _partyController.text,
          phoneNumber: _phoneNumberController.text,
          lokhsabha: _lokhsabhaController.text,
          position: _positionController.text,
          title: '',
        ),
      ),
    );
  }

  Future<void> _sendDataToFastAPI() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.16:8000/process_user_data'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phone_number': _phoneNumberController.text,
          'fullname': _fullnameController.text,
          'party': _partyController.text,
          'lokhsabha': _lokhsabhaController.text,
          'position': _positionController.text,
        }),
      );

      if (response.statusCode == 200) {
        print('Data sent successfully');
        final responseData = jsonDecode(response.body);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                  hphoneNumber: responseData['phonenumber'],
                  hposition: responseData['position'],
                  hfullname: responseData['fullname'],
                  hparty: responseData['party'],
                  hlokhsabha: responseData['lokhsabha'])),
        );
      } else {
        // Handle error response
        print('Error sending data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception while sending data: $e');
    }
  }
}
