import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/services.dart';

class FramesTesting extends StatefulWidget {
  const FramesTesting({
    Key? key,
  }) : super(key: key);

  @override
  State<FramesTesting> createState() => _FramesTestingState();
}

class _FramesTestingState extends State<FramesTesting> {
  ScreenshotController screenshotController = ScreenshotController();
  bool isLoading = false;
  int currentProfileUrlIndex = 0;
  double fontSize = 12.0;

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
                              color: Color.fromRGBO(117, 141, 109, 1),
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
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize,
                                      ),
                                    ),
                                    Text(
                                      'પૂર્વ મંત્રી, ગુજરાત સરકાર',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: fontSize - 2,
                                          fontFamily: 'GujaratiFont1'),
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

                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Container(
                    padding: EdgeInsets.all(5.0), // Adjust padding as needed
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white), // Border color
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Change Font Size:',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'GujaratiFont1'),
                        ),
                        FloatingActionButton(
                          onPressed: _decreaseFontSize,
                          child: Icon(Icons.remove),
                          backgroundColor: Colors.grey[800],
                        ),
                        FloatingActionButton(
                          onPressed: _increaseFontSize,
                          child: Icon(Icons.add),
                          backgroundColor: Colors.grey[800],
                        ),
                      ],
                    ),
                  ),
                ),
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
