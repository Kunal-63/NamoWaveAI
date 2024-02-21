import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _userPhoto;
  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _userPhoto = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        leading: IconButton(
          icon: Icon(
            LineAwesomeIcons.angle_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: _pickPhoto,
              child: CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.grey[200],
                backgroundImage:
                    _userPhoto != null ? FileImage(File(_userPhoto!)) : null,
                child: _userPhoto == null
                    ? Icon(
                        Icons.add_a_photo,
                        size: 30.0,
                        color: Colors.black54,
                      )
                    : null, // No need for SizedBox if the image is selected
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {},
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
