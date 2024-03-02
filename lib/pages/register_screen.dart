import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'crop.dart';

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
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();

  String? _selectedParty;

  bool areFieldsFilled() {
    return controller1.text.isNotEmpty &&
        controller2.text.isNotEmpty &&
        controller3.text.isNotEmpty &&
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

  void _showPoliticalPartiesDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                leading: Image.asset(
                  'assets/flags/bjp.jpg',
                ),
                title: Text('BJP'),
                onTap: () {
                  _setSelectedParty('BJP');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: Image.asset('assets/flags/congress.jpg'),
                title: Text('Congress'),
                onTap: () {
                  _setSelectedParty('Congress');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: Image.asset('assets/flags/aam.jpg'),
                title: Text('AAP'),
                onTap: () {
                  _setSelectedParty('AAP');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: Image.asset('assets/flags/bsp.jpg'),
                title: Text('BSP'),
                onTap: () {
                  _setSelectedParty('BSP');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: Image.asset('assets/flags/sp.jpg'),
                title: Text('SP'),
                onTap: () {
                  _setSelectedParty('SP');
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: Image.asset('assets/flags/tmc.jpg'),
                title: Text('TMC'),
                onTap: () {
                  _setSelectedParty('TMC');
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
          image: AssetImage('assets/registration/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(12, 12, 12, 0.9),
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
                        child: TextField(
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
