import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/services.dart';

class ImageEditor extends StatefulWidget {
  final String imagePath;
  final String fullname;
  final String profileURL;
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

  Future<void> _saveToGallery() async {
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

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar('Text copied to clipboard!');
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
                            color: Color.fromRGBO(
                                (widget.rValue - 20).clamp(0, 255),
                                (widget.gValue - 20).clamp(0, 255),
                                (widget.bValue - 20).clamp(0, 255),
                                1),
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
                              color: Color.fromRGBO(widget.rValue,
                                  widget.gValue, widget.bValue, 1),
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
                              widget.profileURL,
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

  Widget _buildLoremContainer(String text) {
    return Container(
      height: 200,
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: 5),
      color: Colors.grey,
      child: Stack(
        children: [
          Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: Icon(Icons.copy),
              onPressed: () {
                _copyToClipboard(text);
              },
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
  final String profileURL;
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

  Future<void> _saveToGallery() async {
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

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar('Text copied to clipboard!');
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
                            color: Color.fromRGBO(
                                (widget.rValue - 20).clamp(0, 255),
                                (widget.gValue - 20).clamp(0, 255),
                                (widget.bValue - 20).clamp(0, 255),
                                1),
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
                              color: Color.fromRGBO(
                                  (widget.rValue - 20).clamp(0, 255),
                                  (widget.gValue - 20).clamp(0, 255),
                                  (widget.bValue - 20).clamp(0, 255),
                                  1),
                            ),

                            // color: Color.fromRGBO(
                            //     widget.rValue, widget.gValue, widget.bValue, 1),
                          ),
                        ),
                        Positioned(
                            right: -40,
                            bottom: -20,
                            child: Image.network(
                              widget.profileURL,
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

  Widget _buildLoremContainer(String text) {
    return Container(
      height: 200,
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: 5),
      color: Colors.grey,
      child: Stack(
        children: [
          Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: Icon(Icons.copy),
              onPressed: () {
                _copyToClipboard(text);
              },
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
  final String profileURL;
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

  Future<void> _saveToGallery() async {
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

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar('Text copied to clipboard!');
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
                            color: Color.fromRGBO(
                                (widget.rValue - 20).clamp(0, 255),
                                (widget.gValue - 20).clamp(0, 255),
                                (widget.bValue - 20).clamp(0, 255),
                                1),
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
                              color: Color.fromRGBO(widget.rValue,
                                  widget.gValue, widget.bValue, 1),
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
                              widget.profileURL,
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

  Widget _buildLoremContainer(String text) {
    return Container(
      height: 200,
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: 5),
      color: Colors.grey,
      child: Stack(
        children: [
          Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: Icon(Icons.copy),
              onPressed: () {
                _copyToClipboard(text);
              },
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
  final String profileURL;
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

  Future<void> _saveToGallery() async {
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

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar('Text copied to clipboard!');
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
                            color: Color.fromRGBO(
                                (widget.rValue - 20).clamp(0, 255),
                                (widget.gValue - 20).clamp(0, 255),
                                (widget.bValue - 20).clamp(0, 255),
                                1),
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
                            color: Color.fromRGBO(
                                (widget.rValue - 20).clamp(0, 255),
                                (widget.gValue - 20).clamp(0, 255),
                                (widget.bValue - 20).clamp(0, 255),
                                1),
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
                              color: Color.fromRGBO(
                                  (widget.rValue - 20).clamp(0, 255),
                                  (widget.gValue - 20).clamp(0, 255),
                                  (widget.bValue - 20).clamp(0, 255),
                                  1),
                            ),

                            // color: Color.fromRGBO(
                            //     widget.rValue, widget.gValue, widget.bValue, 1),
                          ),
                        ),
                        Positioned(
                            right: -40,
                            bottom: -20,
                            child: Image.network(
                              widget.profileURL,
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

  Widget _buildLoremContainer(String text) {
    return Container(
      height: 200,
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: 5),
      color: Colors.grey,
      child: Stack(
        children: [
          Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: Icon(Icons.copy),
              onPressed: () {
                _copyToClipboard(text);
              },
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
  final String profileURL;
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

  Future<void> _saveToGallery() async {
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

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar('Text copied to clipboard!');
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

                            color: Color.fromRGBO(
                                widget.rValue, widget.gValue, widget.bValue, 1),

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
                              color: Color.fromRGBO(widget.rValue,
                                  widget.gValue, widget.bValue, 1),
                            ),
                          ),
                        ),
                        Positioned(
                            right: -40,
                            bottom: -20,
                            child: Image.network(
                              widget.profileURL,
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

  Widget _buildLoremContainer(String text) {
    return Container(
      height: 200,
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: 5),
      color: Colors.grey,
      child: Stack(
        children: [
          Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: Icon(Icons.copy),
              onPressed: () {
                _copyToClipboard(text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
