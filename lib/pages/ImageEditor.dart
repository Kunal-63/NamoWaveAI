import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageEditor extends StatefulWidget {
  final String imagePath;
  const ImageEditor({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<ImageEditor> createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(12, 12, 12, 1),
        appBar: AppBar(
          title: Text(''),
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
          child: Column(
            children: [
              // Large box with an image
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Screenshot(
                  controller: screenshotController,
                  child: Stack(
                    children: [
                      Image.asset(
                        widget.imagePath,
                        fit: BoxFit.cover,
                        width: 400,
                        height: 400,
                      ),
                      Positioned(
                        right: 25,
                        bottom: 0,
                        child: ClipPath(
                          clipper: BorderClipper(),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(
                                      0xFF3B5998), // Replace with the color of the clothes
                                  width: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          child: Image.asset(
                            'assets\jitu.jpg',
                            width: 150,
                            height: 150,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),

              // Three round buttons
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.grey[800],
                  tooltip: 'Crop',
                  child: const Icon(Icons.crop),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.grey[800],
                  tooltip: 'color',
                  child: const Icon(Icons.color_lens_outlined),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  tooltip: 'Save Image',
                  child: Icon(Icons.download),
                ),
              ]),

              SizedBox(
                height: 30,
              ),

              // Horizontally scrollable list of small boxes
              Container(
                height: 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        color: Colors.grey,
                        child: Center(
                          child: Text('Item 1'),
                        ),
                      ),
                      Container(
                        height: 150,
                        width: 150,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        color: Colors.grey,
                        child: Center(
                          child: Text('Item 2'),
                        ),
                      ),
                      Container(
                        height: 150,
                        width: 150,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        color: Colors.grey,
                        child: Center(
                          child: Text('Item 3'),
                        ),
                      ),
                      Container(
                        height: 150,
                        width: 150,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        color: Colors.grey,
                        child: Center(
                          child: Text('Item 4'),
                        ),
                      ),
                      Container(
                        height: 150,
                        width: 150,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        color: Colors.grey,
                        child: Center(
                          child: Text('Item 5'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),

              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
              ),

              SizedBox(
                height: 30,
              ),

              // Big rectangular-shaped button
              Container(
                width: 400,
                margin: EdgeInsets.all(10),
                child: FloatingActionButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(),
                  backgroundColor: Colors.grey[800],
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ));
  }
}

class BorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - 18); // Adjust the curvature here
    path.quadraticBezierTo(
        size.width, size.height, size.width - 18, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
