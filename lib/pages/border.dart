import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:theog/pages/FramesTesting.dart';
import 'package:theog/pages/ImageEditor.dart'; // Import your ImageEditor subclasses
import 'package:http/http.dart' as http;

class BorderScreen extends StatelessWidget {
  final String imagePathURL;
  final String profileURL;
  final String fullname;
  final String phoneNumber;
  final String position;
  BorderScreen({
    Key? key,
    required this.imagePathURL,
    required this.profileURL,
    required this.phoneNumber,
    required this.fullname,
    required this.position,
  }) : super(key: key);

  final List<String> borderImages = [
    'assets/borders/template1.png',
    'assets/borders/template2.jpg', // Add more image paths as needed
    'assets/borders/template3.jpg',
    'assets/borders/template4.jpg',
    // 'assets/borders/template5.jpg',
    'assets/borders/template6.jpg',
    // 'assets/borders/template7.jpg',
  ];

  Future<Map<String, dynamic>> colorChangeTemplate() async {
    final apiUrl = 'http://localhost:8000/color_change_template';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phoneNumber': phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to load data: $error');
    }
  }

  void _onContainerTap(BuildContext context, String imagePath) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      barrierDismissible: false,
    );

    try {
      Map<String, dynamic> result = await colorChangeTemplate();

      List RGBList = result['RGBValues'];
      List TextList = result['TextColors'];

      Navigator.pop(context);

      // Determine which image was clicked and navigate accordingly
      if (imagePath == borderImages[0]) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return ImageEditor(
              RGBValues: RGBList,
              TextValues: TextList,
              profileURL: [profileURL],
              imagePath: imagePathURL,
              fullname: fullname,
              position: position,
            );
          }),
        );
      } else if (imagePath == borderImages[1]) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return ImageEditor2(
              RGBValues: RGBList,
              TextValues: TextList,
              profileURL: [profileURL],
              imagePath: imagePathURL,
              fullname: fullname,
              position: position,
            );
          }),
        );
      } else if (imagePath == borderImages[2]) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return ImageEditor3(
              RGBValues: RGBList,
              TextValues: TextList,
              profileURL: [profileURL],
              imagePath: imagePathURL,
              fullname: fullname,
              position: position,
            );
          }),
        );
      } else if (imagePath == borderImages[3]) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return ImageEditor4(
              RGBValues: RGBList,
              TextValues: TextList,
              profileURL: [profileURL],
              imagePath: imagePathURL,
              fullname: fullname,
              position: position,
            );
          }),
        );
      } else if (imagePath == borderImages[4]) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return ImageEditor6(
              RGBValues: RGBList,
              TextValues: TextList,
              profileURL: [profileURL],
              imagePath: imagePathURL,
              fullname: fullname,
              position: position,
            );
          }),
        );
      }
    } catch (error) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  Widget _buildImageContainer(BuildContext context, String imagePath1) {
    return GestureDetector(
      onTap: () => _onContainerTap(context, imagePath1),
      child: Container(
        width: 150,
        height: 150,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: Image.asset(imagePath1).image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
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
        backgroundColor: Color.fromRGBO(12, 12, 12, 0.95),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0.0,
          title: Text('Frames'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 20,
                  children: [
                    for (String borderImage in borderImages)
                      _buildImageContainer(context, borderImage),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
