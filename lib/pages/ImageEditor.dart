import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
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
  bool isTranslated = false;
  bool isButtonOnRight = true;

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
    // 'assets/borders/template20.jpg',
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

  void toggleButtonPosition() {
    setState(() {
      isButtonOnRight = !isButtonOnRight;
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

  void toggleTranslation() {
    setState(() {
      isTranslated = !isTranslated;
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
                                height: 55,
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
                          right: isButtonOnRight ? -15 : null,
                          left: isButtonOnRight
                              ? null
                              : 100, // Further adjusted left position
                          bottom: 0,
                          child: Container(
                            width:
                                100, // Adjusted width of the mirrored image container
                            child: Transform(
                              alignment: isButtonOnRight
                                  ? Alignment.center
                                  : Alignment.centerLeft,
                              transform: Matrix4.identity()
                                ..scale(isButtonOnRight ? 1.0 : -1.0, 1.0),
                              child: Image.network(
                                widget.profileURL[currentProfileUrlIndex],
                                height: 100,
                                width: 100,
                                fit: BoxFit
                                    .cover, // Ensure the image fits within the container
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: isButtonOnRight
                              ? (380 - widget.fullname.length * fontSize) / 2
                              : null,
                          right: isButtonOnRight
                              ? null
                              : (360 - widget.fullname.length * fontSize) / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FutureBuilder<String>(
                                future: isTranslated
                                    ? translatedFullName
                                    : Future.value(widget.fullname),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      snapshot.data ?? '',
                                      style: TextStyle(
                                        color: Color.fromRGBO(
                                          widget.TextValues[
                                              currentSelectedColorIndex][0],
                                          widget.TextValues[
                                              currentSelectedColorIndex][1],
                                          widget.TextValues[
                                              currentSelectedColorIndex][2],
                                          1,
                                        ),
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize,
                                        fontFamily: currentFontFamily,
                                      ),
                                    );
                                  }
                                },
                              ),
                              FutureBuilder<String>(
                                future: isTranslated
                                    ? translatedDesignation
                                    : Future.value(widget.position),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      snapshot.data ?? '',
                                      style: TextStyle(
                                        color: Color.fromRGBO(
                                          widget.TextValues[
                                              currentSelectedColorIndex][0],
                                          widget.TextValues[
                                              currentSelectedColorIndex][1],
                                          widget.TextValues[
                                              currentSelectedColorIndex][2],
                                          1,
                                        ),
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize,
                                        fontFamily: currentFontFamily,
                                      ),
                                    );
                                  }
                                },
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: toggleTranslation,
                        child: Text(
                          isTranslated
                              ? 'Switch to English'
                              : 'Switch to Gujarati',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        )),
                    ElevatedButton(
                        onPressed: toggleButtonPosition,
                        child: Text(
                          isButtonOnRight
                              ? "Switch to Left"
                              : "Switch to Right",
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        )),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Text(
                      "AI Generated Color Palette",
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
