import 'dart:ui';
import 'package:flutter/material.dart';
// import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/rendering.dart';
import 'package:translator/translator.dart';

class FramesTesting extends StatefulWidget {
  final List RGBValues;
  final List TextValues;
  const FramesTesting({
    Key? key,
    required this.RGBValues,
    required this.TextValues,
  }) : super(key: key);

  @override
  State<FramesTesting> createState() => _FramesTestingState();
}

class _FramesTestingState extends State<FramesTesting> {
  ScreenshotController screenshotController = ScreenshotController();
  bool isLoading = false;
  int currentProfileUrlIndex = 0;
  double fontSize = 12.0;
  String currentFontFamily = 'Default';
  int currentSelectedColorIndex = 0;
  List<String> fontFamilies = [
    'Default',
    'Arial',
    'Times New Roman',
    'Courier New',
  ];

  void _changeFontFamily(String fontFamily) {
    setState(() {
      currentFontFamily = fontFamily;
    });
  }

  void _saveToGallery() async {
    _showLoading();
    Uint8List? image = await screenshotController.capture();
    if (image != null) {
      final result = await ImageGallerySaver.saveImage(image);
      print(result);

      _hideLoading();
      _showSnackBar('Image saved successfully!');
    } else {
      _hideLoading();
      _showSnackBar('Failed to save image.');
    }
  }

  void _shareImage() async {
    _showLoading();
    Uint8List? imageBytes = await screenshotController.capture();
    if (imageBytes != null) {
      await Share.file(
        'image.png',
        'image.png',
        imageBytes,
        'image/png',
        text: 'Check out this cool image!',
      );
      _hideLoading();
    } else {
      _hideLoading();
      _showSnackBar('Failed to share image.');
    }
  }

  void _showLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void _hideLoading() {
    setState(() {
      isLoading = false;
    });
  }

  void _increaseFontSize() {
    setState(() {
      fontSize += 2.0; // Increase font size by 2.0
    });
  }

  void _decreaseFontSize() {
    setState(() {
      if (fontSize > 2.0) {
        fontSize -=
            2.0; // Decrease font size by 2.0, but ensure it doesn't go below 2.0
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<String> translateToGujarati(String text) async {
    GoogleTranslator translator = GoogleTranslator();

    Translation translation = await translator.translate(
      text,
      from: 'en', // Source language (English)
      to: 'gu', // Target language (Gujarati)
    );

    return translation.text;
  }

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
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                          'assets/templates/template3.png',
                          fit: BoxFit.cover,
                          width: 400,
                          height: 400,
                        ),
                        // Positioned(
                        //   right: 0,
                        //   bottom: 0,
                        //   child: Container(
                        //       width: 400,
                        //       height: 10,
                        //       color: Color.fromRGBO(117, 141, 109, 1)),
                        // ),
                        Positioned(
                          bottom: 10,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.only(left: 7),
                            width: 275,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                              color: Color.fromRGBO(
                                  widget.RGBValues[currentSelectedColorIndex]
                                      [0],
                                  widget.RGBValues[currentSelectedColorIndex]
                                      [1],
                                  widget.RGBValues[currentSelectedColorIndex]
                                      [2],
                                  1),
                            ),
                            child: Row(
                              children: [
                                // Image.asset(
                                //   'assets/instagram.jpeg',
                                //   height: 10,
                                //   width: 10,
                                // ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                // Image.asset(
                                //   'assets/instagram.jpeg',
                                //   height: 10,
                                //   width: 10,
                                // ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                // Image.asset(
                                //   'assets/instagram.jpeg',
                                //   height: 10,
                                //   width: 10,
                                // ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'ધારાસભ્ય, અમદાવાદ વિધાનસભા',
                                      style: TextStyle(
                                        color: Color.fromRGBO(
                                            widget.TextValues[
                                                currentSelectedColorIndex][0],
                                            widget.TextValues[
                                                currentSelectedColorIndex][1],
                                            widget.TextValues[
                                                currentSelectedColorIndex][2],
                                            1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize,
                                        fontFamily: currentFontFamily,
                                      ),
                                    ),
                                    Text(
                                      'પૂર્વ મંત્રી, ગુજરાત સરકાર',
                                      style: TextStyle(
                                        color: Color.fromRGBO(
                                            widget.TextValues[
                                                currentSelectedColorIndex][0],
                                            widget.TextValues[
                                                currentSelectedColorIndex][1],
                                            widget.TextValues[
                                                currentSelectedColorIndex][2],
                                            1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize - 2,
                                        fontFamily: currentFontFamily,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: -20,
                          bottom: 0,
                          child: Image.asset(
                            'assets/image1.png',
                            height: 125,
                            width: 125,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                // Refresh button

                // Three round buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      onPressed: _saveToGallery,
                      backgroundColor: Colors.grey[800],
                      tooltip: 'Save Image',
                      child: Icon(Icons.download),
                    ),
                    FloatingActionButton(
                      onPressed: _shareImage,
                      backgroundColor: Colors.grey[800],
                      tooltip: 'Share',
                      child: Icon(Icons.share),
                    ),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Font Size",
                          style: TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15),
                          child: Container(
                            height: 60,
                            width: 100, // Adjust padding as needed
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white), // Border color
                              borderRadius:
                                  BorderRadius.circular(8.0), // Border radius
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Text(
                                //   'Change Font Size:',
                                //   style: TextStyle(
                                //       color: Colors.white,
                                //       fontFamily: 'GujaratiFont1'),
                                // ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: _decreaseFontSize,
                                    child: Icon(
                                      Icons.remove,
                                      size: 20,
                                    ),
                                    backgroundColor: Colors.grey[800],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: _increaseFontSize,
                                    child: Icon(Icons.add,
                                        size: 20, color: Colors.white),
                                    backgroundColor: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Font Family",
                          style: TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15),
                          child: Container(
                            padding:
                                EdgeInsets.all(5.0), // Adjust padding as needed
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white), // Border color
                              borderRadius:
                                  BorderRadius.circular(8.0), // Border radius
                            ),
                            child: DropdownButton<String>(
                              value: currentFontFamily,
                              onChanged: (String? newFontFamily) {
                                if (newFontFamily != null) {
                                  _changeFontFamily(newFontFamily);
                                }
                              },
                              dropdownColor: Color.fromARGB(241, 12, 12, 12),
                              iconEnabledColor:
                                  Colors.white, // Dropdown button icon color
                              iconDisabledColor:
                                  Colors.white, // Dropdown button icon color
                              focusColor: Color.fromRGBO(
                                  12, 12, 12, 1), // Dropdown button focus color
                              style: TextStyle(
                                  color: Colors
                                      .white), // Dropdown button text color
                              icon: Icon(
                                Icons.arrow_drop_down,
                              ), // Dropdown button icon color
                              underline: Container(),

                              items: fontFamilies.map<DropdownMenuItem<String>>(
                                  (String fontFamily) {
                                return DropdownMenuItem<String>(
                                  value: fontFamily,
                                  child: Text(
                                    fontFamily,
                                    style: TextStyle(
                                        color: Colors
                                            .white), // Dropdown item text color
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Text(
                      "Color Palette",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentSelectedColorIndex = 0;
                            });
                          },
                          child: ClipOval(
                            child: Container(
                              height: 50,
                              width: 50,
                              color: Color.fromRGBO(
                                  widget.RGBValues[0][0],
                                  widget.RGBValues[0][1],
                                  widget.RGBValues[0][2],
                                  1),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentSelectedColorIndex = 1;
                            });
                          },
                          child: ClipOval(
                            child: Container(
                              height: 50,
                              width: 50,
                              color: Color.fromRGBO(
                                  widget.RGBValues[1][0],
                                  widget.RGBValues[1][1],
                                  widget.RGBValues[1][2],
                                  1),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentSelectedColorIndex = 2;
                            });
                          },
                          child: ClipOval(
                            child: Container(
                              height: 50,
                              width: 50,
                              color: Color.fromRGBO(
                                  widget.RGBValues[2][0],
                                  widget.RGBValues[2][1],
                                  widget.RGBValues[2][2],
                                  1),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentSelectedColorIndex = 3;
                            });
                          },
                          child: ClipOval(
                            child: Container(
                              height: 50,
                              width: 50,
                              color: Color.fromRGBO(
                                  widget.RGBValues[3][0],
                                  widget.RGBValues[3][1],
                                  widget.RGBValues[3][2],
                                  1),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentSelectedColorIndex = 4;
                            });
                          },
                          child: ClipOval(
                            child: Container(
                              height: 50,
                              width: 50,
                              color: Color.fromRGBO(
                                  widget.RGBValues[4][0],
                                  widget.RGBValues[4][1],
                                  widget.RGBValues[4][2],
                                  1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
