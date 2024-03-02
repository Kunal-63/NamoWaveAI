import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';

class ImageEditor extends StatefulWidget {
  const ImageEditor({Key? key}) : super(key: key);

  @override
  State<ImageEditor> createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(12, 12, 12, 1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Screenshot(
            controller: screenshotController,
            child: Stack(
              children: [
                Image.asset(
                  'assets/trending2.jpg',
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
                            color: Color(0xFF3B5998),
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
                      'assets/sample_photo.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _saveImage(),
          tooltip: 'Save Image',
          child: Icon(Icons.download),
        ),
      ),
    );
  }

  Future<void> _saveImage() async {
    try {
      final imageBytes = await screenshotController.capture();
      await ImageGallerySaver.saveImage(Uint8List.fromList(imageBytes!));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Image saved to gallery'),
      ));
    } catch (e) {
      print('Error saving image: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error saving image'),
      ));
    }
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
