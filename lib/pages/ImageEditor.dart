import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';

class ImageEditor extends StatefulWidget {
  final String imagePath;
  final String fullname;
  final List profileURL;
  final List RGBValues;
  final List TextValues;
  final String position;
  const ImageEditor({
    Key? key,
    required this.imagePath,
    required this.profileURL,
    required this.RGBValues,
    required this.TextValues,
    required this.fullname,
    required this.position,
  }) : super(key: key);

  @override
  State<ImageEditor> createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  ScreenshotController screenshotController = ScreenshotController();
  bool isLoading = false;
  int currentProfileUrlIndex = 0;
  double fontSize = 10.0;
  String currentFontFamily = 'Default';
  int currentSelectedColorIndex = 0;
  int currentSelectedColorIndex1 = 0;
  late Future<String> translatedFullName;
  late Future<String> translatedDesignation;
  int currentSelectedBackgroundIndex = 0;

  List<String> fontFamilies = [
    'Default',
    'Angkor',
    'Cinzel',
    'IBMPlex',
    'LoraV',
    'LoraI',
    'Whisper',
  ];

  List<String> backgroundImages = [
    'assets/borders/template1.jpg',
    'assets/borders/template2.jpg',
    'assets/borders/template3.jpg',
    'assets/borders/template4.jpg',
    'assets/borders/template5.jpg',
    'assets/borders/template6.jpg',
    'assets/borders/template7.jpg',
    'assets/borders/template8.jpg',
    'assets/borders/template9.jpg',
    'assets/borders/template10.jpg',
    'assets/borders/template11.jpg',
    'assets/borders/template12.jpg',
    'assets/borders/template13.jpg',
    'assets/borders/template14.jpg',
    'assets/borders/template15.jpg',
    'assets/borders/template16.jpg',
    'assets/borders/template17.jpg',
    'assets/borders/template18.jpg',
    'assets/borders/template19.jpg',
    'assets/borders/template20.jpg',
    'assets/borders/template21.jpg',
    'assets/borders/template22.jpg',
    'assets/borders/template23.jpg',
    'assets/borders/template24.jpg',
    'assets/borders/template25.jpg',
    'assets/borders/template26.jpg',
    'assets/borders/template27.jpg',
    'assets/borders/template28.jpg',
    'assets/borders/template29.jpg',
    'assets/borders/template30.jpg',
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

  Map<String, String> fontFamilyTranslations = {
    'Default': 'Default',
    'Angkor': 'Angkor',
    'Cinzel': 'Cinzel',
    'IBMPlex': 'IBMPlex',
    'LoraV': 'LoraV',
    'LoraI': 'LoraI',
    'Teko': 'Teko',
    'Whisper': 'Whisper',
  };

  @override
  void initState() {
    super.initState();
    translatedFullName = translateToGujarati(widget.fullname);
    translatedDesignation = translateToGujarati(widget.position);
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
                  height: 350,
                  child: Screenshot(
                    controller: screenshotController,
                    child: Stack(
                      children: [
                        Container(
                          width: 400,
                          height: 400,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(backgroundImages[
                                    currentSelectedBackgroundIndex]),
                                fit: BoxFit.cover),
                            border: Border.all(color: Colors.black),
                          ),
                        ),
                        Container(
                          width: 400,
                          height: 400,
                          color: Color.fromRGBO(
                              widget.RGBValues[currentSelectedColorIndex][0],
                              widget.RGBValues[currentSelectedColorIndex][1],
                              widget.RGBValues[currentSelectedColorIndex][2],
                              0.6),
                        ),
                        Positioned(
                          top: 27,
                          left: 12.5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0,
                                      2), // Offset in the direction of shadow
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                widget.imagePath,
                                fit: BoxFit.cover,
                                width: 275,
                                height: 275,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 262,
                          right: 15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 85,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(
                                          widget.RGBValues[
                                              currentSelectedColorIndex][0],
                                          widget.RGBValues[
                                              currentSelectedColorIndex][1],
                                          widget.RGBValues[
                                              currentSelectedColorIndex][2],
                                          1),
                                      width:
                                          2.0, // Adjust the thickness of the underline as needed
                                    ),
                                  ),
                                ),
                                child: Image.asset(
                                  'assets/amitshah.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: -10,
                          bottom: 0,
                          child: Image.network(
                            widget.profileURL[currentProfileUrlIndex],
                            height: 100,
                            width: 100,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: (MediaQuery.of(context).size.width -
                                  widget.fullname.length * fontSize) /
                              2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.fullname,
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
                                widget.position,
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
                            ],
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
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.white,
                              focusColor: Color.fromRGBO(12, 12, 12, 1),
                              style: TextStyle(color: Colors.white),
                              icon: Icon(Icons.arrow_drop_down),
                              underline: Container(),
                              items: fontFamilies.map<DropdownMenuItem<String>>(
                                (String fontFamily) {
                                  String translatedFontFamily =
                                      fontFamilyTranslations[fontFamily] ??
                                          fontFamily;
                                  return DropdownMenuItem<String>(
                                    value: fontFamily,
                                    child: Text(
                                      translatedFontFamily,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                },
                              ).toList(),
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentSelectedColorIndex = 5;
                            });
                          },
                          child: ClipOval(
                            child: Container(
                              height: 50,
                              width: 50,
                              color: Color.fromRGBO(
                                  widget.RGBValues[5][0],
                                  widget.RGBValues[5][1],
                                  widget.RGBValues[5][2],
                                  1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Horizontally scrollable list of small boxes
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Text(
                      "Backgrounds",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          for (int i = 0; i < backgroundImages.length; i++)
                            Row(
                              children: [
                                SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentSelectedBackgroundIndex = i;
                                    });
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage(backgroundImages[i]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                              ],
                            ),
                          SizedBox(width: 10),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
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

// class ImageEditor2 extends StatefulWidget {
//   final String imagePath;
//   final String fullname;
//   final List profileURL;
//   final List RGBValues;
//   final List TextValues;
//   final String position;
//   const ImageEditor2({
//     Key? key,
//     required this.imagePath,
//     required this.profileURL,
//     required this.RGBValues,
//     required this.TextValues,
//     required this.fullname,
//     required this.position,
//   }) : super(key: key);

//   @override
//   State<ImageEditor2> createState() => _ImageEditor2State();
// }

// class _ImageEditor2State extends State<ImageEditor2> {
//   ScreenshotController screenshotController = ScreenshotController();
//   bool isLoading = false;
//   int currentProfileUrlIndex = 0;
//   double fontSize = 10.0;
//   String currentFontFamily = 'Default';
//   int currentSelectedColorIndex = 0;
//   int currentSelectedColorIndex1 = 0;
//   late Future<String> translatedFullName;
//   late Future<String> translatedDesignation;

//   List<String> fontFamilies = [
//     'Default',
//     'Arial',
//     'Times New Roman',
//     'Courier New',
//     'Surat',
//     'Ekatra'
//   ];

//   void _changeFontFamily(String fontFamily) {
//     setState(() {
//       currentFontFamily = fontFamily;
//     });
//   }

//   void _saveToGallery() async {
//     _showLoading();
//     Uint8List? image = await screenshotController.capture();
//     if (image != null) {
//       final result = await ImageGallerySaver.saveImage(image);
//       print(result);

//       _hideLoading();
//       _showSnackBar('Image saved successfully!');
//     } else {
//       _hideLoading();
//       _showSnackBar('Failed to save image.');
//     }
//   }

//   void _shareImage() async {
//     _showLoading();
//     Uint8List? imageBytes = await screenshotController.capture();
//     if (imageBytes != null) {
//       await Share.file(
//         'image.png',
//         'image.png',
//         imageBytes,
//         'image/png',
//         text: 'Check out this cool image!',
//       );
//       _hideLoading();
//     } else {
//       _hideLoading();
//       _showSnackBar('Failed to share image.');
//     }
//   }

//   void _showLoading() {
//     setState(() {
//       isLoading = true;
//     });
//   }

//   void _hideLoading() {
//     setState(() {
//       isLoading = false;
//     });
//   }

//   void _increaseFontSize() {
//     setState(() {
//       fontSize += 2.0; // Increase font size by 2.0
//     });
//   }

//   void _decreaseFontSize() {
//     setState(() {
//       if (fontSize > 2.0) {
//         fontSize -=
//             2.0; // Decrease font size by 2.0, but ensure it doesn't go below 2.0
//       }
//     });
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   Future<String> translateToGujarati(String text) async {
//     GoogleTranslator translator = GoogleTranslator();

//     Translation translation = await translator.translate(
//       text,
//       from: 'en', // Source language (English)
//       to: 'gu', // Target language (Gujarati)
//     );

//     return translation.text;
//   }

//   Map<String, String> fontFamilyTranslations = {
//     'Default': 'Default',
//     'Arial': 'Arial',
//     'Times New Roman': 'Times New Roman',
//     'Courier New': 'Courier New',
//     'Acme': 'Acme',
//     'Pacifico': 'Pacifico',
//     'Indie Flower': 'Indie Flower',
//     'Caveat': 'Caveat',
//     'Great Vibes': 'Great Vibes',
//     'Dancing Script': 'Dancing Script',
//     'Poppins': 'Poppins',
//     'Roboto': 'Roboto',
//     'Raleway': 'Raleway',
//     'Lato': 'Lato',
//   };

//   @override
//   void initState() {
//     super.initState();
//     translatedFullName = translateToGujarati(widget.fullname);
//     translatedDesignation = translateToGujarati(widget.position);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(12, 12, 12, 1),
//       appBar: AppBar(
//         title: Text(''),
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Large box with an image
//                 Container(
//                   width: 300,
//                   height: 300,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                   ),
//                   child: Screenshot(
//                     controller: screenshotController,
//                     child: Stack(
//                       children: [
//                         Image.asset(
//                           widget.imagePath,
//                           fit: BoxFit.cover,
//                           width: 400,
//                           height: 400,
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                             width: 400,
//                             height: 5,
//                             color: Color.fromRGBO(
//                                 widget.RGBValues[currentSelectedColorIndex1][0],
//                                 widget.RGBValues[currentSelectedColorIndex1][1],
//                                 widget.RGBValues[currentSelectedColorIndex1][2],
//                                 1),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                             padding:
//                                 EdgeInsets.only(left: 10, top: 5, bottom: 5),
//                             width: translatedFullName.toString().length * 6.8,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 // bottomLeft: Radius.circular(20),
//                               ),
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[currentSelectedColorIndex]
//                                       [0],
//                                   widget.RGBValues[currentSelectedColorIndex]
//                                       [1],
//                                   widget.RGBValues[currentSelectedColorIndex]
//                                       [2],
//                                   1),
//                             ),
//                             child: Row(
//                               children: [
//                                 // Image.asset(
//                                 //   'assets/instagram.jpeg',
//                                 //   height: 10,
//                                 //   width: 10,
//                                 // ),
//                                 // SizedBox(
//                                 //   width: 5,
//                                 // ),
//                                 // Image.asset(
//                                 //   'assets/instagram.jpeg',
//                                 //   height: 10,
//                                 //   width: 10,
//                                 // ),
//                                 // SizedBox(
//                                 //   width: 5,
//                                 // ),
//                                 // Image.asset(
//                                 //   'assets/instagram.jpeg',
//                                 //   height: 10,
//                                 //   width: 10,
//                                 // ),
//                                 // SizedBox(
//                                 //   width: 5,
//                                 // ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     FutureBuilder<String>(
//                                       future: translatedFullName,
//                                       builder: (context, snapshot) {
//                                         if (snapshot.connectionState ==
//                                             ConnectionState.waiting) {
//                                           return CircularProgressIndicator();
//                                         } else if (snapshot.hasError) {
//                                           return Text(
//                                               'Error: ${snapshot.error}');
//                                         } else {
//                                           return FittedBox(
//                                             child: Text(
//                                               snapshot.data ??
//                                                   '', // Use the translated text
//                                               style: TextStyle(
//                                                 color: Color.fromRGBO(
//                                                     widget.TextValues[
//                                                             currentSelectedColorIndex]
//                                                         [0],
//                                                     widget.TextValues[
//                                                             currentSelectedColorIndex]
//                                                         [1],
//                                                     widget.TextValues[
//                                                         currentSelectedColorIndex][2],
//                                                     1),
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: fontSize,
//                                                 fontFamily: currentFontFamily,
//                                               ),
//                                             ),
//                                           );
//                                         }
//                                       },
//                                     ),
//                                     SizedBox(
//                                       height: 2,
//                                     ),
//                                     FutureBuilder<String>(
//                                       future: translatedDesignation,
//                                       builder: (context, snapshot) {
//                                         if (snapshot.connectionState ==
//                                             ConnectionState.waiting) {
//                                           return CircularProgressIndicator();
//                                         } else if (snapshot.hasError) {
//                                           return Text(
//                                               'Error: ${snapshot.error}');
//                                         } else {
//                                           return FittedBox(
//                                             child: Text(
//                                               snapshot.data ??
//                                                   '', // Use the translated text
//                                               style: TextStyle(
//                                                 color: Color.fromRGBO(
//                                                     widget.TextValues[
//                                                             currentSelectedColorIndex]
//                                                         [0],
//                                                     widget.TextValues[
//                                                             currentSelectedColorIndex]
//                                                         [1],
//                                                     widget.TextValues[
//                                                         currentSelectedColorIndex][2],
//                                                     1),
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: fontSize,
//                                                 fontFamily: currentFontFamily,
//                                               ),
//                                             ),
//                                           );
//                                         }
//                                       },
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           right: -10,
//                           bottom: 0,
//                           child: Image.network(
//                             widget.profileURL[currentProfileUrlIndex],
//                             height: 75,
//                             width: 75,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(
//                   height: 30,
//                 ),

//                 // Refresh button

//                 // Three round buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     FloatingActionButton(
//                       onPressed: _saveToGallery,
//                       backgroundColor: Colors.grey[800],
//                       tooltip: 'Save Image',
//                       child: Icon(Icons.download),
//                     ),
//                     FloatingActionButton(
//                       onPressed: _shareImage,
//                       backgroundColor: Colors.grey[800],
//                       tooltip: 'Share',
//                       child: Icon(Icons.share),
//                     ),
//                   ],
//                 ),

//                 SizedBox(
//                   height: 30,
//                 ),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         Text(
//                           "Font Size",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15.0, right: 15),
//                           child: Container(
//                             height: 60,
//                             width: 100, // Adjust padding as needed
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Colors.white), // Border color
//                               borderRadius:
//                                   BorderRadius.circular(8.0), // Border radius
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Container(
//                                   height: 30,
//                                   width: 30,
//                                   child: FloatingActionButton(
//                                     onPressed: _decreaseFontSize,
//                                     child: Icon(
//                                       Icons.remove,
//                                       size: 20,
//                                     ),
//                                     backgroundColor: Colors.grey[800],
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 30,
//                                   width: 30,
//                                   child: FloatingActionButton(
//                                     onPressed: _increaseFontSize,
//                                     child: Icon(Icons.add,
//                                         size: 20, color: Colors.white),
//                                     backgroundColor: Colors.grey[800],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           "Font Family",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15.0, right: 15),
//                           child: Container(
//                             padding:
//                                 EdgeInsets.all(5.0), // Adjust padding as needed
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Colors.white), // Border color
//                               borderRadius:
//                                   BorderRadius.circular(8.0), // Border radius
//                             ),
//                             child: DropdownButton<String>(
//                               value: currentFontFamily,
//                               onChanged: (String? newFontFamily) {
//                                 if (newFontFamily != null) {
//                                   _changeFontFamily(newFontFamily);
//                                 }
//                               },
//                               dropdownColor: Color.fromARGB(241, 12, 12, 12),
//                               iconEnabledColor: Colors.white,
//                               iconDisabledColor: Colors.white,
//                               focusColor: Color.fromRGBO(12, 12, 12, 1),
//                               style: TextStyle(color: Colors.white),
//                               icon: Icon(Icons.arrow_drop_down),
//                               underline: Container(),
//                               items: fontFamilies.map<DropdownMenuItem<String>>(
//                                 (String fontFamily) {
//                                   String translatedFontFamily =
//                                       fontFamilyTranslations[fontFamily] ??
//                                           fontFamily;
//                                   return DropdownMenuItem<String>(
//                                     value: fontFamily,
//                                     child: Text(
//                                       translatedFontFamily,
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   );
//                                 },
//                               ).toList(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       "Color Palette",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 0;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[0][0],
//                                   widget.RGBValues[0][1],
//                                   widget.RGBValues[0][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 1;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[1][0],
//                                   widget.RGBValues[1][1],
//                                   widget.RGBValues[1][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 2;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[2][0],
//                                   widget.RGBValues[2][1],
//                                   widget.RGBValues[2][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 3;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[3][0],
//                                   widget.RGBValues[3][1],
//                                   widget.RGBValues[3][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 4;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[4][0],
//                                   widget.RGBValues[4][1],
//                                   widget.RGBValues[4][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//                 SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 0;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[0][0],
//                               widget.RGBValues[0][1],
//                               widget.RGBValues[0][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 1;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[1][0],
//                               widget.RGBValues[1][1],
//                               widget.RGBValues[1][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 2;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[2][0],
//                               widget.RGBValues[2][1],
//                               widget.RGBValues[2][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 3;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[3][0],
//                               widget.RGBValues[3][1],
//                               widget.RGBValues[3][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 4;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[4][0],
//                               widget.RGBValues[4][1],
//                               widget.RGBValues[4][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           if (isLoading)
//             Container(
//               color: Colors.black.withOpacity(0.5),
//               child: Center(
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class ImageEditor3 extends StatefulWidget {
//   final String imagePath;
//   final String fullname;
//   final List profileURL;
//   final List RGBValues;
//   final List TextValues;
//   final String position;
//   const ImageEditor3({
//     Key? key,
//     required this.imagePath,
//     required this.profileURL,
//     required this.RGBValues,
//     required this.TextValues,
//     required this.fullname,
//     required this.position,
//   }) : super(key: key);

//   @override
//   State<ImageEditor3> createState() => _ImageEditor3State();
// }

// class _ImageEditor3State extends State<ImageEditor3> {
//   ScreenshotController screenshotController = ScreenshotController();
//   bool isLoading = false;
//   int currentProfileUrlIndex = 0;
//   double fontSize = 12.0;
//   String currentFontFamily = 'Default';
//   int currentSelectedColorIndex = 0;
//   int currentSelectedColorIndex1 = 0;
//   late Future<String> translatedFullName;
//   late Future<String> translatedDesignation;

//   List<String> fontFamilies = [
//     'Default',
//     'Arial',
//     'Times New Roman',
//     'Courier New',
//     'Surat',
//     'Ekatra'
//   ];

//   void _changeFontFamily(String fontFamily) {
//     setState(() {
//       currentFontFamily = fontFamily;
//     });
//   }

//   void _saveToGallery() async {
//     _showLoading();
//     Uint8List? image = await screenshotController.capture();
//     if (image != null) {
//       final result = await ImageGallerySaver.saveImage(image);
//       print(result);

//       _hideLoading();
//       _showSnackBar('Image saved successfully!');
//     } else {
//       _hideLoading();
//       _showSnackBar('Failed to save image.');
//     }
//   }

//   void _shareImage() async {
//     _showLoading();
//     Uint8List? imageBytes = await screenshotController.capture();
//     if (imageBytes != null) {
//       await Share.file(
//         'image.png',
//         'image.png',
//         imageBytes,
//         'image/png',
//         text: 'Check out this cool image!',
//       );
//       _hideLoading();
//     } else {
//       _hideLoading();
//       _showSnackBar('Failed to share image.');
//     }
//   }

//   void _showLoading() {
//     setState(() {
//       isLoading = true;
//     });
//   }

//   void _hideLoading() {
//     setState(() {
//       isLoading = false;
//     });
//   }

//   void _increaseFontSize() {
//     setState(() {
//       fontSize += 2.0; // Increase font size by 2.0
//     });
//   }

//   void _decreaseFontSize() {
//     setState(() {
//       if (fontSize > 2.0) {
//         fontSize -=
//             2.0; // Decrease font size by 2.0, but ensure it doesn't go below 2.0
//       }
//     });
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   Future<String> translateToGujarati(String text) async {
//     GoogleTranslator translator = GoogleTranslator();

//     Translation translation = await translator.translate(
//       text,
//       from: 'en', // Source language (English)
//       to: 'gu', // Target language (Gujarati)
//     );

//     return translation.text;
//   }

//   Map<String, String> fontFamilyTranslations = {
//     'Default': 'Default',
//     'Arial': 'Arial',
//     'Times New Roman': 'Times New Roman',
//     'Courier New': 'Courier New',
//     'Acme': 'Acme',
//     'Pacifico': 'Pacifico',
//     'Indie Flower': 'Indie Flower',
//     'Caveat': 'Caveat',
//     'Great Vibes': 'Great Vibes',
//     'Dancing Script': 'Dancing Script',
//     'Poppins': 'Poppins',
//     'Roboto': 'Roboto',
//     'Raleway': 'Raleway',
//     'Lato': 'Lato',
//   };

//   @override
//   void initState() {
//     super.initState();
//     translatedFullName = translateToGujarati(widget.fullname);
//     translatedDesignation = translateToGujarati(widget.position);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(12, 12, 12, 1),
//       appBar: AppBar(
//         title: Text(''),
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Large box with an image
//                 Container(
//                   width: 300,
//                   height: 300,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                   ),
//                   child: Screenshot(
//                     controller: screenshotController,
//                     child: Stack(
//                       children: [
//                         Image.asset(
//                           widget.imagePath,
//                           fit: BoxFit.cover,
//                           width: 400,
//                           height: 400,
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           left: 0,
//                           child: Container(
//                             width: translatedFullName.toString().length * 8,
//                             height: 20,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(10)),
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[currentSelectedColorIndex1]
//                                       [0],
//                                   widget.RGBValues[currentSelectedColorIndex1]
//                                       [1],
//                                   widget.RGBValues[currentSelectedColorIndex1]
//                                       [2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 19,
//                           left: 0,
//                           child: Container(
//                             padding:
//                                 EdgeInsets.only(left: 150, top: 5, bottom: 5),
//                             width: 120,
//                             height: 20,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(20),
//                                 // bottomLeft: Radius.circular(20),
//                               ),
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[currentSelectedColorIndex]
//                                       [0],
//                                   widget.RGBValues[currentSelectedColorIndex]
//                                       [1],
//                                   widget.RGBValues[currentSelectedColorIndex]
//                                       [2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           left: -10,
//                           bottom: 0,
//                           child: Image.network(
//                             widget.profileURL[currentProfileUrlIndex],
//                             height: 75,
//                             width: 75,
//                           ),
//                         ),
//                         Positioned(
//                           right: 95,
//                           bottom: 3,
//                           child: Row(
//                             children: [
//                               // Image.asset(
//                               //   'assets/instagram.jpeg',
//                               //   height: 10,
//                               //   width: 10,
//                               // ),
//                               // SizedBox(
//                               //   width: 5,
//                               // ),
//                               // Image.asset(
//                               //   'assets/instagram.jpeg',
//                               //   height: 10,
//                               //   width: 10,
//                               // ),
//                               // SizedBox(
//                               //   width: 5,
//                               // ),
//                               // Image.asset(
//                               //   'assets/instagram.jpeg',
//                               //   height: 10,
//                               //   width: 10,
//                               // ),
//                               // SizedBox(
//                               //   width: 5,
//                               // ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   FutureBuilder<String>(
//                                     future: translatedFullName,
//                                     builder: (context, snapshot) {
//                                       if (snapshot.connectionState ==
//                                           ConnectionState.waiting) {
//                                         return CircularProgressIndicator();
//                                       } else if (snapshot.hasError) {
//                                         return Text('Error: ${snapshot.error}');
//                                       } else {
//                                         return FittedBox(
//                                           child: Text(
//                                             snapshot.data ??
//                                                 '', // Use the translated text
//                                             style: TextStyle(
//                                               color: Color.fromRGBO(
//                                                   widget.TextValues[
//                                                           currentSelectedColorIndex1]
//                                                       [0],
//                                                   widget.TextValues[
//                                                           currentSelectedColorIndex1]
//                                                       [1],
//                                                   widget.TextValues[
//                                                       currentSelectedColorIndex1][2],
//                                                   1),
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: fontSize,
//                                               fontFamily: currentFontFamily,
//                                             ),
//                                           ),
//                                         );
//                                       }
//                                     },
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(
//                   height: 30,
//                 ),

//                 // Refresh button

//                 // Three round buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     FloatingActionButton(
//                       onPressed: _saveToGallery,
//                       backgroundColor: Colors.grey[800],
//                       tooltip: 'Save Image',
//                       child: Icon(Icons.download),
//                     ),
//                     FloatingActionButton(
//                       onPressed: _shareImage,
//                       backgroundColor: Colors.grey[800],
//                       tooltip: 'Share',
//                       child: Icon(Icons.share),
//                     ),
//                   ],
//                 ),

//                 SizedBox(
//                   height: 30,
//                 ),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         Text(
//                           "Font Size",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15.0, right: 15),
//                           child: Container(
//                             height: 60,
//                             width: 100, // Adjust padding as needed
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Colors.white), // Border color
//                               borderRadius:
//                                   BorderRadius.circular(8.0), // Border radius
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Container(
//                                   height: 30,
//                                   width: 30,
//                                   child: FloatingActionButton(
//                                     onPressed: _decreaseFontSize,
//                                     child: Icon(
//                                       Icons.remove,
//                                       size: 20,
//                                     ),
//                                     backgroundColor: Colors.grey[800],
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 30,
//                                   width: 30,
//                                   child: FloatingActionButton(
//                                     onPressed: _increaseFontSize,
//                                     child: Icon(Icons.add,
//                                         size: 20, color: Colors.white),
//                                     backgroundColor: Colors.grey[800],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           "Font Family",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15.0, right: 15),
//                           child: Container(
//                             padding:
//                                 EdgeInsets.all(5.0), // Adjust padding as needed
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Colors.white), // Border color
//                               borderRadius:
//                                   BorderRadius.circular(8.0), // Border radius
//                             ),
//                             child: DropdownButton<String>(
//                               value: currentFontFamily,
//                               onChanged: (String? newFontFamily) {
//                                 if (newFontFamily != null) {
//                                   _changeFontFamily(newFontFamily);
//                                 }
//                               },
//                               dropdownColor: Color.fromARGB(241, 12, 12, 12),
//                               iconEnabledColor: Colors.white,
//                               iconDisabledColor: Colors.white,
//                               focusColor: Color.fromRGBO(12, 12, 12, 1),
//                               style: TextStyle(color: Colors.white),
//                               icon: Icon(Icons.arrow_drop_down),
//                               underline: Container(),
//                               items: fontFamilies.map<DropdownMenuItem<String>>(
//                                 (String fontFamily) {
//                                   String translatedFontFamily =
//                                       fontFamilyTranslations[fontFamily] ??
//                                           fontFamily;
//                                   return DropdownMenuItem<String>(
//                                     value: fontFamily,
//                                     child: Text(
//                                       translatedFontFamily,
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   );
//                                 },
//                               ).toList(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       "Color Palette",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 0;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[0][0],
//                                   widget.RGBValues[0][1],
//                                   widget.RGBValues[0][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 1;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[1][0],
//                                   widget.RGBValues[1][1],
//                                   widget.RGBValues[1][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 2;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[2][0],
//                                   widget.RGBValues[2][1],
//                                   widget.RGBValues[2][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 3;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[3][0],
//                                   widget.RGBValues[3][1],
//                                   widget.RGBValues[3][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 4;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[4][0],
//                                   widget.RGBValues[4][1],
//                                   widget.RGBValues[4][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//                 SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 0;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[0][0],
//                               widget.RGBValues[0][1],
//                               widget.RGBValues[0][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 1;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[1][0],
//                               widget.RGBValues[1][1],
//                               widget.RGBValues[1][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 2;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[2][0],
//                               widget.RGBValues[2][1],
//                               widget.RGBValues[2][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 3;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[3][0],
//                               widget.RGBValues[3][1],
//                               widget.RGBValues[3][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 4;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[4][0],
//                               widget.RGBValues[4][1],
//                               widget.RGBValues[4][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           if (isLoading)
//             Container(
//               color: Colors.black.withOpacity(0.5),
//               child: Center(
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class ImageEditor4 extends StatefulWidget {
//   final String imagePath;
//   final String fullname;
//   final List profileURL;
//   final List RGBValues;
//   final List TextValues;
//   final String position;
//   const ImageEditor4({
//     Key? key,
//     required this.imagePath,
//     required this.profileURL,
//     required this.RGBValues,
//     required this.TextValues,
//     required this.fullname,
//     required this.position,
//   }) : super(key: key);

//   @override
//   State<ImageEditor4> createState() => _ImageEditor4State();
// }

// class _ImageEditor4State extends State<ImageEditor4> {
//   ScreenshotController screenshotController = ScreenshotController();
//   bool isLoading = false;
//   int currentProfileUrlIndex = 0;
//   double fontSize = 12.0;
//   String currentFontFamily = 'Default';
//   int currentSelectedColorIndex = 0;
//   int currentSelectedColorIndex1 = 0;
//   late Future<String> translatedFullName;
//   late Future<String> translatedDesignation;

//   List<String> fontFamilies = [
//     'Default',
//     'Arial',
//     'Times New Roman',
//     'Courier New',
//     'Surat',
//     'Ekatra'
//   ];

//   void _changeFontFamily(String fontFamily) {
//     setState(() {
//       currentFontFamily = fontFamily;
//     });
//   }

//   void _saveToGallery() async {
//     _showLoading();
//     Uint8List? image = await screenshotController.capture();
//     if (image != null) {
//       final result = await ImageGallerySaver.saveImage(image);
//       print(result);

//       _hideLoading();
//       _showSnackBar('Image saved successfully!');
//     } else {
//       _hideLoading();
//       _showSnackBar('Failed to save image.');
//     }
//   }

//   void _shareImage() async {
//     _showLoading();
//     Uint8List? imageBytes = await screenshotController.capture();
//     if (imageBytes != null) {
//       await Share.file(
//         'image.png',
//         'image.png',
//         imageBytes,
//         'image/png',
//         text: 'Check out this cool image!',
//       );
//       _hideLoading();
//     } else {
//       _hideLoading();
//       _showSnackBar('Failed to share image.');
//     }
//   }

//   void _showLoading() {
//     setState(() {
//       isLoading = true;
//     });
//   }

//   void _hideLoading() {
//     setState(() {
//       isLoading = false;
//     });
//   }

//   void _increaseFontSize() {
//     setState(() {
//       fontSize += 2.0; // Increase font size by 2.0
//     });
//   }

//   void _decreaseFontSize() {
//     setState(() {
//       if (fontSize > 2.0) {
//         fontSize -=
//             2.0; // Decrease font size by 2.0, but ensure it doesn't go below 2.0
//       }
//     });
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   Future<String> translateToGujarati(String text) async {
//     GoogleTranslator translator = GoogleTranslator();

//     Translation translation = await translator.translate(
//       text,
//       from: 'en', // Source language (English)
//       to: 'gu', // Target language (Gujarati)
//     );

//     return translation.text;
//   }

//   Map<String, String> fontFamilyTranslations = {
//     'Default': 'Default',
//     'Arial': 'Arial',
//     'Times New Roman': 'Times New Roman',
//     'Courier New': 'Courier New',
//     'Acme': 'Acme',
//     'Pacifico': 'Pacifico',
//     'Indie Flower': 'Indie Flower',
//     'Caveat': 'Caveat',
//     'Great Vibes': 'Great Vibes',
//     'Dancing Script': 'Dancing Script',
//     'Poppins': 'Poppins',
//     'Roboto': 'Roboto',
//     'Raleway': 'Raleway',
//     'Lato': 'Lato',
//   };

//   @override
//   void initState() {
//     super.initState();
//     translatedFullName = translateToGujarati(widget.fullname);
//     translatedDesignation = translateToGujarati(widget.position);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(12, 12, 12, 1),
//       appBar: AppBar(
//         title: Text(''),
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Large box with an image
//                 Container(
//                   width: 300,
//                   height: 300,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                   ),
//                   child: Screenshot(
//                     controller: screenshotController,
//                     child: Stack(
//                       children: [
//                         Image.asset(
//                           widget.imagePath,
//                           fit: BoxFit.cover,
//                           width: 400,
//                           height: 400,
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           left: 0,
//                           child: Container(
//                             width: 300,
//                             height: 7,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                   // topRight: Radius.circular(10),
//                                   ),
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[currentSelectedColorIndex1]
//                                       [0],
//                                   widget.RGBValues[currentSelectedColorIndex1]
//                                       [1],
//                                   widget.RGBValues[currentSelectedColorIndex1]
//                                       [2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 6,
//                           left: 0,
//                           child: Container(
//                             padding:
//                                 EdgeInsets.only(left: 150, top: 5, bottom: 5),
//                             width: translatedFullName.toString().length * 4.5,
//                             height: 35,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(20),
//                                 // bottomLeft: Radius.circular(20),
//                               ),
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[currentSelectedColorIndex]
//                                       [0],
//                                   widget.RGBValues[currentSelectedColorIndex]
//                                       [1],
//                                   widget.RGBValues[currentSelectedColorIndex]
//                                       [2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           right: -10,
//                           bottom: 0,
//                           child: Image.network(
//                             widget.profileURL[currentProfileUrlIndex],
//                             height: 75,
//                             width: 75,
//                           ),
//                         ),
//                         Positioned(
//                           left: 25,
//                           bottom: 3,
//                           child: Row(
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   FutureBuilder<String>(
//                                     future: translatedFullName,
//                                     builder: (context, snapshot) {
//                                       if (snapshot.connectionState ==
//                                           ConnectionState.waiting) {
//                                         return CircularProgressIndicator();
//                                       } else if (snapshot.hasError) {
//                                         return Text('Error: ${snapshot.error}');
//                                       } else {
//                                         return FittedBox(
//                                           child: Text(
//                                             snapshot.data ??
//                                                 '', // Use the translated text
//                                             style: TextStyle(
//                                               color: Color.fromRGBO(
//                                                   widget.TextValues[
//                                                           currentSelectedColorIndex1]
//                                                       [0],
//                                                   widget.TextValues[
//                                                           currentSelectedColorIndex1]
//                                                       [1],
//                                                   widget.TextValues[
//                                                       currentSelectedColorIndex1][2],
//                                                   1),
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: fontSize,
//                                               fontFamily: currentFontFamily,
//                                             ),
//                                           ),
//                                         );
//                                       }
//                                     },
//                                   ),
//                                   SizedBox(
//                                     height: 3,
//                                   ),
//                                   FutureBuilder<String>(
//                                     future: translatedDesignation,
//                                     builder: (context, snapshot) {
//                                       if (snapshot.connectionState ==
//                                           ConnectionState.waiting) {
//                                         return CircularProgressIndicator();
//                                       } else if (snapshot.hasError) {
//                                         return Text('Error: ${snapshot.error}');
//                                       } else {
//                                         return FittedBox(
//                                           child: Text(
//                                             snapshot.data ??
//                                                 '', // Use the translated text
//                                             style: TextStyle(
//                                               color: Color.fromRGBO(
//                                                   widget.TextValues[
//                                                           currentSelectedColorIndex1]
//                                                       [0],
//                                                   widget.TextValues[
//                                                           currentSelectedColorIndex1]
//                                                       [1],
//                                                   widget.TextValues[
//                                                       currentSelectedColorIndex1][2],
//                                                   1),
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: fontSize - 2,
//                                               fontFamily: currentFontFamily,
//                                             ),
//                                           ),
//                                         );
//                                       }
//                                     },
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(
//                   height: 30,
//                 ),

//                 // Refresh button

//                 // Three round buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     FloatingActionButton(
//                       onPressed: _saveToGallery,
//                       backgroundColor: Colors.grey[800],
//                       tooltip: 'Save Image',
//                       child: Icon(Icons.download),
//                     ),
//                     FloatingActionButton(
//                       onPressed: _shareImage,
//                       backgroundColor: Colors.grey[800],
//                       tooltip: 'Share',
//                       child: Icon(Icons.share),
//                     ),
//                   ],
//                 ),

//                 SizedBox(
//                   height: 30,
//                 ),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         Text(
//                           "Font Size",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15.0, right: 15),
//                           child: Container(
//                             height: 60,
//                             width: 100, // Adjust padding as needed
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Colors.white), // Border color
//                               borderRadius:
//                                   BorderRadius.circular(8.0), // Border radius
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Container(
//                                   height: 30,
//                                   width: 30,
//                                   child: FloatingActionButton(
//                                     onPressed: _decreaseFontSize,
//                                     child: Icon(
//                                       Icons.remove,
//                                       size: 20,
//                                     ),
//                                     backgroundColor: Colors.grey[800],
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 30,
//                                   width: 30,
//                                   child: FloatingActionButton(
//                                     onPressed: _increaseFontSize,
//                                     child: Icon(Icons.add,
//                                         size: 20, color: Colors.white),
//                                     backgroundColor: Colors.grey[800],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           "Font Family",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15.0, right: 15),
//                           child: Container(
//                             padding:
//                                 EdgeInsets.all(5.0), // Adjust padding as needed
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Colors.white), // Border color
//                               borderRadius:
//                                   BorderRadius.circular(8.0), // Border radius
//                             ),
//                             child: DropdownButton<String>(
//                               value: currentFontFamily,
//                               onChanged: (String? newFontFamily) {
//                                 if (newFontFamily != null) {
//                                   _changeFontFamily(newFontFamily);
//                                 }
//                               },
//                               dropdownColor: Color.fromARGB(241, 12, 12, 12),
//                               iconEnabledColor: Colors.white,
//                               iconDisabledColor: Colors.white,
//                               focusColor: Color.fromRGBO(12, 12, 12, 1),
//                               style: TextStyle(color: Colors.white),
//                               icon: Icon(Icons.arrow_drop_down),
//                               underline: Container(),
//                               items: fontFamilies.map<DropdownMenuItem<String>>(
//                                 (String fontFamily) {
//                                   String translatedFontFamily =
//                                       fontFamilyTranslations[fontFamily] ??
//                                           fontFamily;
//                                   return DropdownMenuItem<String>(
//                                     value: fontFamily,
//                                     child: Text(
//                                       translatedFontFamily,
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   );
//                                 },
//                               ).toList(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       "Color Palette",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 0;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[0][0],
//                                   widget.RGBValues[0][1],
//                                   widget.RGBValues[0][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 1;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[1][0],
//                                   widget.RGBValues[1][1],
//                                   widget.RGBValues[1][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 2;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[2][0],
//                                   widget.RGBValues[2][1],
//                                   widget.RGBValues[2][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 3;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[3][0],
//                                   widget.RGBValues[3][1],
//                                   widget.RGBValues[3][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 4;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[4][0],
//                                   widget.RGBValues[4][1],
//                                   widget.RGBValues[4][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//                 SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 0;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[0][0],
//                               widget.RGBValues[0][1],
//                               widget.RGBValues[0][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 1;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[1][0],
//                               widget.RGBValues[1][1],
//                               widget.RGBValues[1][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 2;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[2][0],
//                               widget.RGBValues[2][1],
//                               widget.RGBValues[2][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 3;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[3][0],
//                               widget.RGBValues[3][1],
//                               widget.RGBValues[3][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 4;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[4][0],
//                               widget.RGBValues[4][1],
//                               widget.RGBValues[4][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           if (isLoading)
//             Container(
//               color: Colors.black.withOpacity(0.5),
//               child: Center(
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class ImageEditor6 extends StatefulWidget {
//   final String imagePath;
//   final String fullname;
//   final List profileURL;
//   final List RGBValues;
//   final List TextValues;
//   final String position;
//   const ImageEditor6({
//     Key? key,
//     required this.imagePath,
//     required this.profileURL,
//     required this.RGBValues,
//     required this.TextValues,
//     required this.fullname,
//     required this.position,
//   }) : super(key: key);

//   @override
//   State<ImageEditor6> createState() => _ImageEditor6State();
// }

// class _ImageEditor6State extends State<ImageEditor6> {
//   ScreenshotController screenshotController = ScreenshotController();
//   bool isLoading = false;
//   int currentProfileUrlIndex = 0;
//   double fontSize = 10.0;
//   String currentFontFamily = 'Default';
//   int currentSelectedColorIndex = 0;
//   int currentSelectedColorIndex1 = 0;
//   late Future<String> translatedFullName;
//   late Future<String> translatedDesignation;

//   List<String> fontFamilies = [
//     'Default',
//     'Arial',
//     'Times New Roman',
//     'Courier New',
//     'Surat',
//     'Ekatra'
//   ];

//   void _changeFontFamily(String fontFamily) {
//     setState(() {
//       currentFontFamily = fontFamily;
//     });
//   }

//   void _saveToGallery() async {
//     _showLoading();
//     Uint8List? image = await screenshotController.capture();
//     if (image != null) {
//       final result = await ImageGallerySaver.saveImage(image);
//       print(result);

//       _hideLoading();
//       _showSnackBar('Image saved successfully!');
//     } else {
//       _hideLoading();
//       _showSnackBar('Failed to save image.');
//     }
//   }

//   void _shareImage() async {
//     _showLoading();
//     Uint8List? imageBytes = await screenshotController.capture();
//     if (imageBytes != null) {
//       await Share.file(
//         'image.png',
//         'image.png',
//         imageBytes,
//         'image/png',
//         text: 'Check out this cool image!',
//       );
//       _hideLoading();
//     } else {
//       _hideLoading();
//       _showSnackBar('Failed to share image.');
//     }
//   }

//   void _showLoading() {
//     setState(() {
//       isLoading = true;
//     });
//   }

//   void _hideLoading() {
//     setState(() {
//       isLoading = false;
//     });
//   }

//   void _increaseFontSize() {
//     setState(() {
//       fontSize += 2.0; // Increase font size by 2.0
//     });
//   }

//   void _decreaseFontSize() {
//     setState(() {
//       if (fontSize > 2.0) {
//         fontSize -=
//             2.0; // Decrease font size by 2.0, but ensure it doesn't go below 2.0
//       }
//     });
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   Future<String> translateToGujarati(String text) async {
//     GoogleTranslator translator = GoogleTranslator();

//     Translation translation = await translator.translate(
//       text,
//       from: 'en', // Source language (English)
//       to: 'gu', // Target language (Gujarati)
//     );

//     return translation.text;
//   }

//   Map<String, String> fontFamilyTranslations = {
//     'Default': 'Default',
//     'Arial': 'Arial',
//     'Times New Roman': 'Times New Roman',
//     'Courier New': 'Courier New',
//     'Acme': 'Acme',
//     'Pacifico': 'Pacifico',
//     'Indie Flower': 'Indie Flower',
//     'Caveat': 'Caveat',
//     'Great Vibes': 'Great Vibes',
//     'Dancing Script': 'Dancing Script',
//     'Poppins': 'Poppins',
//     'Roboto': 'Roboto',
//     'Raleway': 'Raleway',
//     'Lato': 'Lato',
//   };

//   @override
//   void initState() {
//     super.initState();
//     translatedFullName = translateToGujarati(widget.fullname);
//     translatedDesignation = translateToGujarati(widget.position);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(12, 12, 12, 1),
//       appBar: AppBar(
//         title: Text(''),
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Large box with an image
//                 Container(
//                   width: 300,
//                   height: 300,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                   ),
//                   child: Screenshot(
//                     controller: screenshotController,
//                     child: Stack(
//                       children: [
//                         Image.asset(
//                           widget.imagePath,
//                           fit: BoxFit.cover,
//                           width: 400,
//                           height: 400,
//                         ),
//                         Positioned(
//                           bottom: 7,
//                           right: 0,
//                           child: Container(
//                             width: 400,
//                             height: 20,
//                             color: Color.fromRGBO(
//                                 widget.RGBValues[currentSelectedColorIndex1][0],
//                                 widget.RGBValues[currentSelectedColorIndex1][1],
//                                 widget.RGBValues[currentSelectedColorIndex1][2],
//                                 1),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                             padding:
//                                 EdgeInsets.only(left: 10, top: 5, bottom: 5),
//                             width: translatedFullName.toString().length * 6.8,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 // bottomLeft: Radius.circular(20),
//                               ),
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[currentSelectedColorIndex]
//                                       [0],
//                                   widget.RGBValues[currentSelectedColorIndex]
//                                       [1],
//                                   widget.RGBValues[currentSelectedColorIndex]
//                                       [2],
//                                   1),
//                             ),
//                             child: Row(
//                               children: [
//                                 // Image.asset(
//                                 //   'assets/instagram.jpeg',
//                                 //   height: 10,
//                                 //   width: 10,
//                                 // ),
//                                 // SizedBox(
//                                 //   width: 5,
//                                 // ),
//                                 // Image.asset(
//                                 //   'assets/instagram.jpeg',
//                                 //   height: 10,
//                                 //   width: 10,
//                                 // ),
//                                 // SizedBox(
//                                 //   width: 5,
//                                 // ),
//                                 // Image.asset(
//                                 //   'assets/instagram.jpeg',
//                                 //   height: 10,
//                                 //   width: 10,
//                                 // ),
//                                 // SizedBox(
//                                 //   width: 5,
//                                 // ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     FutureBuilder<String>(
//                                       future: translatedFullName,
//                                       builder: (context, snapshot) {
//                                         if (snapshot.connectionState ==
//                                             ConnectionState.waiting) {
//                                           return CircularProgressIndicator();
//                                         } else if (snapshot.hasError) {
//                                           return Text(
//                                               'Error: ${snapshot.error}');
//                                         } else {
//                                           return FittedBox(
//                                             child: Text(
//                                               snapshot.data ??
//                                                   '', // Use the translated text
//                                               style: TextStyle(
//                                                 color: Color.fromRGBO(
//                                                     widget.TextValues[
//                                                             currentSelectedColorIndex]
//                                                         [0],
//                                                     widget.TextValues[
//                                                             currentSelectedColorIndex]
//                                                         [1],
//                                                     widget.TextValues[
//                                                         currentSelectedColorIndex][2],
//                                                     1),
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: fontSize,
//                                                 fontFamily: currentFontFamily,
//                                               ),
//                                             ),
//                                           );
//                                         }
//                                       },
//                                     ),
//                                     SizedBox(
//                                       height: 2,
//                                     ),
//                                     FutureBuilder<String>(
//                                       future: translatedDesignation,
//                                       builder: (context, snapshot) {
//                                         if (snapshot.connectionState ==
//                                             ConnectionState.waiting) {
//                                           return CircularProgressIndicator();
//                                         } else if (snapshot.hasError) {
//                                           return Text(
//                                               'Error: ${snapshot.error}');
//                                         } else {
//                                           return FittedBox(
//                                             child: Text(
//                                               snapshot.data ??
//                                                   '', // Use the translated text
//                                               style: TextStyle(
//                                                 color: Color.fromRGBO(
//                                                     widget.TextValues[
//                                                             currentSelectedColorIndex]
//                                                         [0],
//                                                     widget.TextValues[
//                                                             currentSelectedColorIndex]
//                                                         [1],
//                                                     widget.TextValues[
//                                                         currentSelectedColorIndex][2],
//                                                     1),
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: fontSize,
//                                                 fontFamily: currentFontFamily,
//                                               ),
//                                             ),
//                                           );
//                                         }
//                                       },
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           right: -10,
//                           bottom: 0,
//                           child: Image.network(
//                             widget.profileURL[currentProfileUrlIndex],
//                             height: 75,
//                             width: 75,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(
//                   height: 30,
//                 ),

//                 // Refresh button

//                 // Three round buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     FloatingActionButton(
//                       onPressed: _saveToGallery,
//                       backgroundColor: Colors.grey[800],
//                       tooltip: 'Save Image',
//                       child: Icon(Icons.download),
//                     ),
//                     FloatingActionButton(
//                       onPressed: _shareImage,
//                       backgroundColor: Colors.grey[800],
//                       tooltip: 'Share',
//                       child: Icon(Icons.share),
//                     ),
//                   ],
//                 ),

//                 SizedBox(
//                   height: 30,
//                 ),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         Text(
//                           "Font Size",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15.0, right: 15),
//                           child: Container(
//                             height: 60,
//                             width: 100, // Adjust padding as needed
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Colors.white), // Border color
//                               borderRadius:
//                                   BorderRadius.circular(8.0), // Border radius
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Container(
//                                   height: 30,
//                                   width: 30,
//                                   child: FloatingActionButton(
//                                     onPressed: _decreaseFontSize,
//                                     child: Icon(
//                                       Icons.remove,
//                                       size: 20,
//                                     ),
//                                     backgroundColor: Colors.grey[800],
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 30,
//                                   width: 30,
//                                   child: FloatingActionButton(
//                                     onPressed: _increaseFontSize,
//                                     child: Icon(Icons.add,
//                                         size: 20, color: Colors.white),
//                                     backgroundColor: Colors.grey[800],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           "Font Family",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15.0, right: 15),
//                           child: Container(
//                             padding:
//                                 EdgeInsets.all(5.0), // Adjust padding as needed
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Colors.white), // Border color
//                               borderRadius:
//                                   BorderRadius.circular(8.0), // Border radius
//                             ),
//                             child: DropdownButton<String>(
//                               value: currentFontFamily,
//                               onChanged: (String? newFontFamily) {
//                                 if (newFontFamily != null) {
//                                   _changeFontFamily(newFontFamily);
//                                 }
//                               },
//                               dropdownColor: Color.fromARGB(241, 12, 12, 12),
//                               iconEnabledColor: Colors.white,
//                               iconDisabledColor: Colors.white,
//                               focusColor: Color.fromRGBO(12, 12, 12, 1),
//                               style: TextStyle(color: Colors.white),
//                               icon: Icon(Icons.arrow_drop_down),
//                               underline: Container(),
//                               items: fontFamilies.map<DropdownMenuItem<String>>(
//                                 (String fontFamily) {
//                                   String translatedFontFamily =
//                                       fontFamilyTranslations[fontFamily] ??
//                                           fontFamily;
//                                   return DropdownMenuItem<String>(
//                                     value: fontFamily,
//                                     child: Text(
//                                       translatedFontFamily,
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   );
//                                 },
//                               ).toList(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       "Color Palette",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 0;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[0][0],
//                                   widget.RGBValues[0][1],
//                                   widget.RGBValues[0][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 1;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[1][0],
//                                   widget.RGBValues[1][1],
//                                   widget.RGBValues[1][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 2;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[2][0],
//                                   widget.RGBValues[2][1],
//                                   widget.RGBValues[2][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 3;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[3][0],
//                                   widget.RGBValues[3][1],
//                                   widget.RGBValues[3][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedColorIndex = 4;
//                             });
//                           },
//                           child: ClipOval(
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               color: Color.fromRGBO(
//                                   widget.RGBValues[4][0],
//                                   widget.RGBValues[4][1],
//                                   widget.RGBValues[4][2],
//                                   1),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//                 SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 0;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[0][0],
//                               widget.RGBValues[0][1],
//                               widget.RGBValues[0][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 1;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[1][0],
//                               widget.RGBValues[1][1],
//                               widget.RGBValues[1][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 2;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[2][0],
//                               widget.RGBValues[2][1],
//                               widget.RGBValues[2][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 3;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[3][0],
//                               widget.RGBValues[3][1],
//                               widget.RGBValues[3][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentSelectedColorIndex1 = 4;
//                         });
//                       },
//                       child: ClipOval(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           color: Color.fromRGBO(
//                               widget.RGBValues[4][0],
//                               widget.RGBValues[4][1],
//                               widget.RGBValues[4][2],
//                               1),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           if (isLoading)
//             Container(
//               color: Colors.black.withOpacity(0.5),
//               child: Center(
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
