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
  File? _userPhoto;
  String? _selectedParty;

  Future<void> _pickPhoto(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(12, 12, 12, 0.8),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.0),
              Container(
                  child: Image.asset(
                'assets/sample.gif',
                fit: BoxFit.cover,
              )),
              SizedBox(
                height: 10,
              ),
              ListTile(
                shape: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.blue,
                )),
                leading: Icon(
                  Icons.camera,
                  color: Colors.blue,
                ),
                title: Text(
                  'Take a Photo',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
                onTap: () {
                  _getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                shape: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.blue,
                )),
                leading: Icon(
                  Icons.photo,
                  color: Colors.blue,
                ),
                title: Text(
                  'Choose from Gallery',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
                onTap: () {
                  _getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _userPhoto = File(pickedImage.path);
      });
    }
  }

  // Future<void> _pickPhoto() async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedImage != null) {
  //     setState(() {
  //       _userPhoto = File(pickedImage.path);
  //     });
  //   }
  // }

  void _clearPhoto() {
    setState(() {
      _userPhoto = null;
    });
  }

  void _showPoliticalPartiesDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                leading: Icon(LineAwesomeIcons.flag),
                title: Text('Party 1'),
                onTap: () {
                  _setSelectedParty('Party 1');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(LineAwesomeIcons.flag),
                title: Text('Party 2'),
                onTap: () {
                  _setSelectedParty('Party 2');
                  Navigator.pop(context);
                },
              ),
              // Add more parties as needed
            ],
          ),
        );
      },
    );
  }

  void _setSelectedParty(String party) {
    setState(() {
      _selectedParty = party;
      print('Selected party: $_selectedParty');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(12, 12, 12, 1),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            ElevatedButton(
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
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45.0),
                        child: _userPhoto != null
                            ? Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.file(
                                    _userPhoto!,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: 5.0,
                                    right: 5.0,
                                    child: IconButton(
                                      icon: Icon(LineAwesomeIcons.trash,
                                          size: 20.0),
                                      onPressed: _clearPhoto,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                child: InkWell(
                                  onTap: () {
                                    _pickPhoto(context);
                                  },
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 30.0,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 70,
                        child: TextFormField(
                          maxLines: 1,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            labelText: 'Full Name',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 70,
                        child: TextFormField(
                          controller: TextEditingController(
                            text: _selectedParty ?? '',
                          ),
                          maxLines: 1,
                          onTap: () {
                            // Show political parties dialog
                            _showPoliticalPartiesDialog(context);
                          },
                          // initialValue: _selectedParty,
                          readOnly: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.bubble_chart,
                              color: Colors.white,
                            ),
                            labelText: 'Political Party',
                            hintText: 'Select your political party',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 70,
                        child: TextFormField(
                          maxLines: 1,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              LineAwesomeIcons.briefcase,
                              color: Colors.white,
                            ),
                            labelText: 'Position',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 70,
                        child: TextFormField(
                          maxLines: 1,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_city,
                              color: Colors.white,
                            ),
                            labelText: 'Lokhsabha Constituency',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // Container(
                      //   width: MediaQuery.of(context).size.width * 0.8,
                      //   height: 70,
                      //   child: TextFormField(
                      //     maxLines: 1,
                      //     decoration: InputDecoration(
                      //       prefixIcon: Icon(
                      //         Icons.password,
                      //         color: Colors.black,
                      //       ),
                      //       suffix: Icon(LineAwesomeIcons.eye),
                      //       labelText: 'Password',
                      //       labelStyle: TextStyle(
                      //         color: Colors.black,
                      //       ),
                      //       border: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 10.0),
                      // Container(
                      //   width: MediaQuery.of(context).size.width * 0.8,
                      //   height: 70,
                      //   child: TextFormField(
                      //     maxLines: 1,
                      //     decoration: InputDecoration(
                      //       prefixIcon: Icon(
                      //         Icons.password,
                      //         color: Colors.black,
                      //       ),
                      //       hintText: 'Re-enter your password',
                      //       labelText: 'Confirm Password',
                      //       suffix: Icon(LineAwesomeIcons.eye),
                      //       labelStyle: TextStyle(
                      //         color: Colors.black,
                      //       ),
                      //       border: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 20.0),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                          child: Text('Register'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.grey[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
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
