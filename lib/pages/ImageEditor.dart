import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/services.dart';

Color calculateColor(int r, int g, int b) {
  try {
    // Ensure that color values are within the valid range
    r = (r - 20).clamp(0, 255);
    g = (g - 20).clamp(0, 255);
    b = (b - 20).clamp(0, 255);

    // Return the calculated color
    return Color.fromRGBO(r, g, b, 1);
  } catch (e) {
    // Handle any potential errors (e.g., if color values are null)
    print("Error calculating color: $e");
    return Colors.orange; // Provide a default color
  }
}

class ImageEditor extends StatefulWidget {
  final String imagePath;
  final String fullname;
  final List profileURL;
  final int rValue;
  final int gValue;
  final int bValue;

  const ImageEditor({
    Key? key,
    required this.imagePath,
    required this.profileURL,
    required this.rValue,
    required this.gValue,
    required this.bValue,
    required this.fullname,
  }) : super(key: key);

  @override
  State<ImageEditor> createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  ScreenshotController screenshotController = ScreenshotController();
  bool isLoading = false;
  int currentProfileUrlIndex = 0;

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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _refreshProfileUrl() {
    setState(() {
      currentProfileUrlIndex =
          (currentProfileUrlIndex + 1) % widget.profileURL.length;
    });
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
                        Image.network(
                          widget.imagePath,
                          fit: BoxFit.cover,
                          width: 400,
                          height: 400,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 400,
                            height: 10,
                            color: calculateColor(
                              widget.rValue,
                              widget.gValue,
                              widget.bValue,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.only(top: 7, left: 10),
                            width: 185,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                              ),
                              color: calculateColor(
                                widget.rValue,
                                widget.gValue,
                                widget.bValue,
                              ),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/instagram.jpeg',
                                  height: 10,
                                  width: 10,
                                ),
                                Text(
                                  widget.fullname,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: -40,
                          bottom: -20,
                          child: Image.network(
                            widget.profileURL[currentProfileUrlIndex],
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
                    FloatingActionButton(
                        onPressed: _refreshProfileUrl,
                        backgroundColor: Colors.grey[800],
                        tooltip: 'Refresh',
                        child: Icon(Icons.refresh)),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),

                // Horizontally scrollable list of small boxes
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

class ImageEditor2 extends StatefulWidget {
  final String imagePath;
  final String fullname;
  final List profileURL;
  final int rValue;
  final int gValue;
  final int bValue;

  const ImageEditor2({
    Key? key,
    required this.imagePath,
    required this.profileURL,
    required this.rValue,
    required this.gValue,
    required this.bValue,
    required this.fullname,
  }) : super(key: key);

  @override
  State<ImageEditor2> createState() => _ImageEditor2State();
}

class _ImageEditor2State extends State<ImageEditor2> {
  ScreenshotController screenshotController = ScreenshotController();
  bool isLoading = false;
  int currentProfileUrlIndex = 0;

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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _refreshProfileUrl() {
    setState(() {
      currentProfileUrlIndex =
          (currentProfileUrlIndex + 1) % widget.profileURL.length;
    });
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
                        Image.network(
                          widget.imagePath,
                          fit: BoxFit.cover,
                          width: 400,
                          height: 400,
                        ),
                        Positioned(
                          left: 0,
                          bottom: 15,
                          child: Container(
                            width: 100,
                            height: 10,
                            padding: EdgeInsets.only(top: 7, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            color: calculateColor(
                                widget.rValue, widget.gValue, widget.bValue),
                            child: Text(
                              widget.fullname,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.only(top: 7, left: 10),
                            width: 285,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              color: calculateColor(
                                  widget.rValue, widget.gValue, widget.bValue),
                            ),

                            // color: Color.fromRGBO(
                            //     widget.rValue, widget.gValue, widget.bValue, 1),
                          ),
                        ),
                        Positioned(
                            right: -40,
                            bottom: -20,
                            child: Image.network(
                              widget.profileURL[currentProfileUrlIndex],
                              height: 125,
                              width: 125,
                            ))
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                // Three round buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // FloatingActionButton(
                    //   onPressed: () {},
                    //   backgroundColor: Colors.grey[800],
                    //   tooltip: 'Crop',
                    //   child: const Icon(Icons.crop),
                    // ),
                    // FloatingActionButton(
                    //   onPressed: () {},
                    //   backgroundColor: Colors.grey[800],
                    //   tooltip: 'color',
                    //   child: const Icon(Icons.color_lens_outlined),
                    // ),
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
                    FloatingActionButton(
                        onPressed: _refreshProfileUrl,
                        backgroundColor: Colors.grey[800],
                        tooltip: 'Refresh',
                        child: Icon(Icons.refresh)),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),

                // Horizontally scrollable list of small boxes
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

class ImageEditor4 extends StatefulWidget {
  final String imagePath;
  final String fullname;
  final List profileURL;
  final int rValue;
  final int gValue;
  final int bValue;

  const ImageEditor4({
    Key? key,
    required this.imagePath,
    required this.profileURL,
    required this.rValue,
    required this.gValue,
    required this.bValue,
    required this.fullname,
  }) : super(key: key);

  @override
  State<ImageEditor4> createState() => _ImageEditor4State();
}

class _ImageEditor4State extends State<ImageEditor4> {
  ScreenshotController screenshotController = ScreenshotController();
  bool isLoading = false;
  int currentProfileUrlIndex = 0;

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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _refreshProfileUrl() {
    setState(() {
      currentProfileUrlIndex =
          (currentProfileUrlIndex + 1) % widget.profileURL.length;
    });
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
                        Image.network(
                          widget.imagePath,
                          fit: BoxFit.cover,
                          width: 400,
                          height: 400,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 400,
                            height: 10,
                            color: calculateColor(
                                widget.rValue, widget.gValue, widget.bValue),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            padding: EdgeInsets.only(top: 7, right: 10),
                            width: 185,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                              ),
                              color: calculateColor(
                                  widget.rValue, widget.gValue, widget.bValue),
                            ),
                            child: Text(
                              widget.fullname,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            // color: Color.fromRGBO(
                            //     widget.rValue, widget.gValue, widget.bValue, 1),
                          ),
                        ),
                        Positioned(
                            right: -40,
                            bottom: -20,
                            child: Image.network(
                              widget.profileURL[currentProfileUrlIndex],
                              height: 125,
                              width: 125,
                            ))
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                // Three round buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // FloatingActionButton(
                    //   onPressed: () {},
                    //   backgroundColor: Colors.grey[800],
                    //   tooltip: 'Crop',
                    //   child: const Icon(Icons.crop),
                    // ),
                    // FloatingActionButton(
                    //   onPressed: () {},
                    //   backgroundColor: Colors.grey[800],
                    //   tooltip: 'color',
                    //   child: const Icon(Icons.color_lens_outlined),
                    // ),
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
                    FloatingActionButton(
                        onPressed: _refreshProfileUrl,
                        backgroundColor: Colors.grey[800],
                        tooltip: 'Refresh',
                        child: Icon(Icons.refresh)),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),

                // Horizontally scrollable list of small boxes
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

class ImageEditor3 extends StatefulWidget {
  final String imagePath;
  final String fullname;
  final List profileURL;
  final int rValue;
  final int gValue;
  final int bValue;

  const ImageEditor3({
    Key? key,
    required this.imagePath,
    required this.profileURL,
    required this.rValue,
    required this.gValue,
    required this.bValue,
    required this.fullname,
  }) : super(key: key);

  @override
  State<ImageEditor3> createState() => _ImageEditor3State();
}

class _ImageEditor3State extends State<ImageEditor3> {
  ScreenshotController screenshotController = ScreenshotController();
  bool isLoading = false;
  int currentProfileUrlIndex = 0;

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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _refreshProfileUrl() {
    setState(() {
      currentProfileUrlIndex =
          (currentProfileUrlIndex + 1) % widget.profileURL.length;
    });
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
                        Image.network(
                          widget.imagePath,
                          fit: BoxFit.cover,
                          width: 400,
                          height: 400,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 400,
                            height: 10,
                            color: calculateColor(
                                widget.rValue, widget.gValue, widget.bValue),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 15,
                          child: Container(
                            width: 100,
                            height: 10,
                            padding: EdgeInsets.only(top: 7, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                // bottomRight: Radius.circular(20),
                              ),
                            ),
                            color: calculateColor(
                                widget.rValue, widget.gValue, widget.bValue),
                            child: Text(
                              widget.fullname,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.only(top: 7, left: 10),
                            width: 285,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                // bottomLeft: Radius.circular(20),
                              ),
                              color: calculateColor(
                                  widget.rValue, widget.gValue, widget.bValue),
                            ),

                            // color: Color.fromRGBO(
                            //     widget.rValue, widget.gValue, widget.bValue, 1),
                          ),
                        ),
                        Positioned(
                            right: -40,
                            bottom: -20,
                            child: Image.network(
                              widget.profileURL[currentProfileUrlIndex],
                              height: 125,
                              width: 125,
                            ))
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                // Three round buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // FloatingActionButton(
                    //   onPressed: () {},
                    //   backgroundColor: Colors.grey[800],
                    //   tooltip: 'Crop',
                    //   child: const Icon(Icons.crop),
                    // ),
                    // FloatingActionButton(
                    //   onPressed: () {},
                    //   backgroundColor: Colors.grey[800],
                    //   tooltip: 'color',
                    //   child: const Icon(Icons.color_lens_outlined),
                    // ),
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
                    FloatingActionButton(
                        onPressed: _refreshProfileUrl,
                        backgroundColor: Colors.grey[800],
                        tooltip: 'Refresh',
                        child: Icon(Icons.refresh)),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),

                // Horizontally scrollable list of small boxes
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

class ImageEditor5 extends StatefulWidget {
  final String imagePath;
  final String fullname;
  final List profileURL;
  final int rValue;
  final int gValue;
  final int bValue;

  const ImageEditor5({
    Key? key,
    required this.imagePath,
    required this.profileURL,
    required this.rValue,
    required this.gValue,
    required this.bValue,
    required this.fullname,
  }) : super(key: key);

  @override
  State<ImageEditor5> createState() => _ImageEditor5State();
}

class _ImageEditor5State extends State<ImageEditor5> {
  ScreenshotController screenshotController = ScreenshotController();
  bool isLoading = false;
  int currentProfileUrlIndex = 0;

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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _refreshProfileUrl() {
    setState(() {
      currentProfileUrlIndex =
          (currentProfileUrlIndex + 1) % widget.profileURL.length;
    });
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
                        Image.network(
                          widget.imagePath,
                          fit: BoxFit.cover,
                          width: 400,
                          height: 400,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            padding: EdgeInsets.only(top: 7, right: 10),
                            width: 400,
                            height: 10,

                            color: calculateColor(
                                widget.rValue, widget.gValue, widget.bValue),

                            child: Text(
                              widget.fullname,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            // color: Color.fromRGBO(
                            //     widget.rValue, widget.gValue, widget.bValue, 1),
                          ),
                        ),
                        Positioned(
                          right: -25,
                          bottom: -25,
                          child: Container(
                            width: 85,
                            height: 85,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: calculateColor(
                                  widget.rValue, widget.gValue, widget.bValue),
                            ),
                          ),
                        ),
                        Positioned(
                            right: -40,
                            bottom: -20,
                            child: Image.network(
                              widget.profileURL[currentProfileUrlIndex],
                              height: 125,
                              width: 125,
                            ))
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                // Three round buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // FloatingActionButton(
                    //   onPressed: () {},
                    //   backgroundColor: Colors.grey[800],
                    //   tooltip: 'Crop',
                    //   child: const Icon(Icons.crop),
                    // ),
                    // FloatingActionButton(
                    //   onPressed: () {},
                    //   backgroundColor: Colors.grey[800],
                    //   tooltip: 'color',
                    //   child: const Icon(Icons.color_lens_outlined),
                    // ),
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
                    FloatingActionButton(
                      onPressed: _refreshProfileUrl,
                      backgroundColor: Colors.grey[800],
                      tooltip: 'Refresh',
                      child: Icon(Icons.refresh),
                    ),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),

                // Horizontally scrollable list of small boxes
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
