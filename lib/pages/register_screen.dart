import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'crop.dart';

class RegisterScreen extends StatefulWidget {
  final String title;
  final String phoneNumber;

  const RegisterScreen({
    Key? key,
    required this.title,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();

  String? _selectedParty;
  @override
  void initState() {
    super.initState();
    _selectedParty = "BJP";
  }

  bool areFieldsFilled() {
    return controller1.text.isNotEmpty &&
        controller2.text.isNotEmpty &&
        controller3.text.isNotEmpty &&
        controller4.text.isNotEmpty &&
        _selectedParty != null;
  }

  void _showFillDataPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Incomplete Data'),
          content: Text('Please fill all the fields.'),
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

  // void _showPositionsDialog(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             ListTile(
  //               title: Text('President'),
  //               onTap: () {
  //                 _setSelectedPosition('President');
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             SizedBox(
  //               height: 5,
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _setSelectedPosition(String position) {
  //   setState(() {
  //     controller2.text = position;
  //     print('Selected party: $_selectedParty');
  //   });
  // }

  void _showLokhsabhaDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Text('Ahmedabad'),
                onTap: () {
                  _setSelectedLokhsabha('Ahmedabad');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Gandhinagar'),
                onTap: () {
                  _setSelectedLokhsabha('Gandhinagar');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Surat'),
                onTap: () {
                  _setSelectedLokhsabha('Surat');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Vadodara'),
                onTap: () {
                  _setSelectedLokhsabha('Vadodara');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Rajkot'),
                onTap: () {
                  _setSelectedLokhsabha('Rajkot');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Bhavnagar'),
                onTap: () {
                  _setSelectedLokhsabha('Bhavnagar');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Jamnagar'),
                onTap: () {
                  _setSelectedLokhsabha('Jamnagar');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Junagadh'),
                onTap: () {
                  _setSelectedLokhsabha('Junagadh');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Surendranagar'),
                onTap: () {
                  _setSelectedLokhsabha('Surendranagar');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Anand'),
                onTap: () {
                  _setSelectedLokhsabha('Anand');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Kheda'),
                onTap: () {
                  _setSelectedLokhsabha('Kheda');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Panchmahal'),
                onTap: () {
                  _setSelectedLokhsabha('Panchmahal');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Dahod'),
                onTap: () {
                  _setSelectedLokhsabha('Dahod');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Vadodara'),
                onTap: () {
                  _setSelectedLokhsabha('Vadodara');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Chhota Udaipur'),
                onTap: () {
                  _setSelectedLokhsabha('Chhota Udaipur');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Bharuch'),
                onTap: () {
                  _setSelectedLokhsabha('Bharuch');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Bardoli'),
                onTap: () {
                  _setSelectedLokhsabha('Bardoli');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Surat'),
                onTap: () {
                  _setSelectedLokhsabha('Surat');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Navsari'),
                onTap: () {
                  _setSelectedLokhsabha('Navsari');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Valsad'),
                onTap: () {
                  _setSelectedLokhsabha('Valsad');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Bhavnagar'),
                onTap: () {
                  _setSelectedLokhsabha('Bhavnagar');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Ankleshwar'),
                onTap: () {
                  _setSelectedLokhsabha('Ankleshwar');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Chhota Udaipur'),
                onTap: () {
                  _setSelectedLokhsabha('Chhota Udaipur');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        );
      },
    );
  }

  void _setSelectedLokhsabha(String position) {
    setState(() {
      controller3.text = position;
      print('Selected party: $_selectedParty');
    });
  }

  void _showVidhanSabhaDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Text('Dahegam'),
                onTap: () {
                  _setSelectedVidhanSabha('Dahegam');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Gandhinagar South'),
                onTap: () {
                  _setSelectedVidhanSabha('Gandhinagar South');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Gandhinagar North'),
                onTap: () {
                  _setSelectedVidhanSabha('Gandhinagar North');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Mansa'),
                onTap: () {
                  _setSelectedVidhanSabha('Mansa');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text('Kalol'),
                onTap: () {
                  _setSelectedVidhanSabha('Kalol');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        );
      },
    );
  }

  void _setSelectedVidhanSabha(String position) {
    setState(() {
      controller4.text = position;
      print('Selected party: $_selectedParty');
    });
  }

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
        backgroundColor: Color.fromRGBO(12, 12, 12, 0.7),
        appBar: AppBar(
          title: Text(widget.title),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
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
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 70,
                        child: TextField(
                          controller: controller1,
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
                          // onTap: () {
                          //   // Show political parties dialog
                          //   _showPoliticalPartiesDialog(context);
                          // },
                          // initialValue: _selectedParty,
                          // readOnly: true,
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
                          controller: controller2,
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
                          controller: controller3,
                          style: TextStyle(color: Colors.white),
                          maxLines: 1,
                          onTap: () {
                            // Show political parties dialog
                            _showLokhsabhaDialog(context);
                          },
                          readOnly: true,
                          // initialValue: controller3.text,
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
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 70,
                        child: TextFormField(
                          controller: controller4,
                          style: TextStyle(color: Colors.white),
                          maxLines: 1,
                          onTap: () {
                            // Show political parties dialog
                            _showVidhanSabhaDialog(context);
                          },
                          readOnly: true,
                          // initialValue: controller4.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_city,
                              color: Colors.white,
                            ),
                            labelText: 'VidhanSabha Constituency',
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
                        child: ElevatedButton(
                          onPressed: () {
                            if (areFieldsFilled()) {
                              // All fields are filled, proceed with registration
                              // Uncomment the sendData() method call when you want to send data
                              // sendData();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CropPage(
                                    title: " ",
                                    fullname: controller1.text,
                                    party: "$_selectedParty",
                                    position: controller2.text,
                                    lokhsabha: controller3.text,
                                    vidhansabha: controller4.text,
                                    phoneNumber: widget.phoneNumber,
                                  ),
                                ),
                              );
                            } else {
                              // Show popup if fields are not filled
                              _showFillDataPopup(context);
                            }
                          },
                          child: Text(
                            'Register',
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
