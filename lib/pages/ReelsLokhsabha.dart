import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:theog/pages/ImageEditor.dart';
import 'dart:convert';
import 'package:video_player/video_player.dart';

class ReelsLokhsabhScreen extends StatefulWidget {
  final String lokhSabhaName;
  final String profileURL;
  final String phoneNumber;
  final String fullname;
  final String position;
  ReelsLokhsabhScreen({
    required this.lokhSabhaName,
    required this.profileURL,
    required this.phoneNumber,
    required this.fullname,
    required this.position,
  });

  @override
  State<ReelsLokhsabhScreen> createState() => _ReelsLokhsabhScreenState();
}

class _ReelsLokhsabhScreenState extends State<ReelsLokhsabhScreen> {
  final List<String> images = [
    'assets/home/home1.jpg',
    'assets/home/home2.jpg',
    'assets/home/home3.jpg',
  ];
  int _currentIndex = 0;
  int _currentImageIndex = 0;
  VideoPlayerController? _controller;
  void _onButtonTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<String> buttonTitles = [
    'Dahegam',
    'Gandhinagar South',
    'Gandhinagar North',
    'Mansa',
    'Kalol'
  ];

  List<String> templates = [
    'assets/ZETACORE.mp4',
    'assets/ZETACORE.mp4',
    'assets/ZETACORE.mp4',
    'assets/ZETACORE.mp4',
    // 'assets/templates/template5.png',
    // 'assets/templates/template6.png',
  ]; // List to store template paths
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      templates.first,
    )..initialize().then((_) {
        setState(() {});
      });
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
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            '${widget.lokhSabhaName}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(3),
                height: 25,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 5),
                      for (int i = 0; i < buttonTitles.length; i++)
                        ElevatedButton(
                          onPressed: () => _onButtonTapped(i),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: _currentIndex == i
                                ? Colors.grey[800] // Selected button color
                                : Colors.transparent, // Text color
                          ),
                          child: Text(buttonTitles[i]),
                        ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
              ),

              CarouselSlider.builder(
                itemCount: images.length,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.3,
                  aspectRatio: 1 / 1,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  },
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Image.asset(
                    images[index],
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Templates',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Use a ListView.builder to dynamically create containers
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: (templates.length / 2).ceil(),
                itemBuilder: (context, index) {
                  int startIndex = index * 2;
                  int endIndex = startIndex + 1;

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (startIndex < templates.length)
                            _buildVideoContainer(
                                context, templates[startIndex]),
                          if (endIndex < templates.length)
                            _buildVideoContainer(context, templates[endIndex]),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> colorChangeTemplate() async {
    final apiUrl = 'http://65.2.123.1:8000/color_change_template';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phoneNumber': widget.phoneNumber,
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

      RGBList.add([255, 255, 255]);
      TextList.add([0, 0, 0]);

      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return ImageEditor(
            RGBValues: RGBList,
            TextValues: TextList,
            profileURL: [widget.profileURL],
            imagePath: imagePath,
            fullname: widget.fullname,
            position: widget.position,
          );
        }),
      );
    } catch (e) {
      print(e);
    }
  }

  Widget _buildVideoContainer(BuildContext context, String videoPath) {
    return GestureDetector(
      onTap: () => _onContainerTap(context, videoPath),
      child: Container(
        height: 150,
        width: 150,
        margin: EdgeInsets.symmetric(horizontal: 8), // Adjust spacing here
        child: AspectRatio(
          aspectRatio: 1.0,
          child: _controller != null && _controller!.value.isInitialized
              ? VideoPlayer(_controller!)
              : Container(), // Return an empty container if _controller is null or not initialized
        ),
      ),
    );
  }
}
