import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:flutter/foundation.dart';
import 'package:theog/pages/crop.dart';

class RegisterScreen extends StatefulWidget {
  final String title;

  const RegisterScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _selectedParty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(12, 12, 12, 1),
      appBar: !kIsWeb
          ? AppBar(
              title: Text(widget.title),
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
            )
          : null,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 70,
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
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
                        style: TextStyle(color: Colors.white),
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
                        style: TextStyle(color: Colors.white),
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
                        style: TextStyle(color: Colors.white),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CropPage(
                                title: '',
                              ),
                            ),
                          );
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
    );
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
}
