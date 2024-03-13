import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theog/pages/home_screen.dart';

class CropPage extends StatefulWidget {
  final String title;
  final String fullname;
  final String party;
  final String position;
  final String lokhsabha;
  final String phoneNumber;
  final String vidhansabha;

  const CropPage({
    Key? key,
    required this.title,
    required this.fullname,
    required this.party,
    required this.lokhsabha,
    required this.position,
    required this.phoneNumber,
    required this.vidhansabha,
  }) : super(key: key);

  @override
  _CropPageState createState() => _CropPageState();
}

class _CropPageState extends State<CropPage> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;
  bool _isLoading = false; // Added loading indicator state

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
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  if (_croppedFile != null || _pickedFile != null)
                    _imageCard()
                  else
                    _uploaderCard(),
                ],
              ),
            ),
            if (_isLoading)
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
      ),
    );
  }

  Widget _imageCard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _image(),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          _menu(),
        ],
      ),
    );
  }

  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: Image.file(File(path)),
      );
    } else if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _menu() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_croppedFile == null)
          FloatingActionButton(
            onPressed: () {
              _clear();
            },
            backgroundColor: Colors.redAccent,
            tooltip: 'Delete',
            child: const Icon(Icons.delete),
          ),
        if (_croppedFile == null)
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: FloatingActionButton(
              onPressed: () {
                _cropImage();
              },
              backgroundColor: Colors.grey[800],
              tooltip: 'Crop',
              child: const Icon(Icons.crop),
            ),
          ),
        if (_croppedFile != null)
          FloatingActionButton(
            onPressed: () {
              _clear();
            },
            backgroundColor: Colors.redAccent,
            tooltip: 'Delete',
            child: const Icon(Icons.delete),
          ),
        if (_croppedFile != null)
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: FloatingActionButton(
              onPressed: () {
                _sendDataToFastAPI();
              },
              backgroundColor: const Color(0xFFBC764A),
              tooltip: 'done',
              child: const Icon(Icons.check_box),
            ),
          ),
      ],
    );
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Color.fromRGBO(12, 12, 12, 1),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  Future<void> _sendDataToFastAPI() async {
    try {
      String base64Image = "";

      if (_croppedFile != null) {
        List<int> imageBytes = await File(_croppedFile!.path).readAsBytes();
        base64Image = base64Encode(imageBytes);
      }

      _showLoading();

      final response = await http.post(
        Uri.parse('http://65.2.123.1:8000/process_user_data'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phone_number': widget.phoneNumber,
          'fullname': widget.fullname,
          'party': widget.party,
          'lokhsabha': widget.lokhsabha,
          'position': widget.position,
          'vidhansabha': widget.vidhansabha,
          'image': base64Image,
        }),
      );

      if (response.statusCode == 200) {
        print('Data sent successfully');
        final responseData = jsonDecode(response.body);
        print(responseData);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('firstTimeLogin', false);
        prefs.setString('userPhoneNumber', widget.phoneNumber);
        prefs.setString('userFullName', responseData['fullname']);
        prefs.setString('userPosition', responseData['position']);
        prefs.setString('userParty', responseData['party']);
        prefs.setString('userLokSabha', responseData['lokhsabha']);
        prefs.setString('userVidhanSabha', responseData['vidhansabha']);
        prefs.setString('userProfileURL', responseData['profile_url']);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      hphoneNumber: widget.phoneNumber,
                      hfullname: responseData['fullname'],
                      hposition: responseData['position'],
                      hparty: responseData['party'],
                      hlokhsabha: responseData['lokhsabha'],
                      hvidhansabha: responseData['vidhansabha'],
                      profileURL: responseData['profile_url'],
                    )));
      } else {
        print('Error sending data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception while sending data: $e');
    } finally {
      _hideLoading(); // Ensure loading indicator is hidden after response or exception
    }
  }

  void _showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  void _hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }

  Widget _uploaderCard() {
    return Center(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: 320.0,
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorder(
                    radius: const Radius.circular(12.0),
                    borderType: BorderType.RRect,
                    dashPattern: const [8, 4],
                    color: Theme.of(context).highlightColor.withOpacity(0.4),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Theme.of(context).highlightColor,
                            size: 80.0,
                          ),
                          const SizedBox(height: 24.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey[700],
                  ),
                  onPressed: () {
                    _uploadImage();
                  },
                  child: const Text('Upload'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _showSampleImagePopup();
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  void _showSampleImagePopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sample Image'),
          content: Image.asset(
            'assets/registration/sample_image.gif',
            height: 150.0,
            width: 150.0,
            fit: BoxFit.cover,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
