import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:theog/pages/ImageEditor.dart';
import 'dart:convert';

import 'package:theog/pages/border.dart';

class LokhSabhaScreen extends StatefulWidget {
  final String lokhSabhaName;
  final String profileURL;
  final String phoneNumber;
  final String fullname;
  final String position;
  LokhSabhaScreen({
    required this.lokhSabhaName,
    required this.profileURL,
    required this.phoneNumber,
    required this.fullname,
    required this.position,
  });

  @override
  State<LokhSabhaScreen> createState() => _LokhSabhaScreenState();
}

class _LokhSabhaScreenState extends State<LokhSabhaScreen> {
  final List<String> images = [
    'assets/home/home1.jpg',
    'assets/home/home2.jpg',
    'assets/home/home3.jpg',
  ];
  int _currentIndex = 0;
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
    'assets/templates/template1.png',
    'assets/templates/template2.png',
    'assets/templates/template3.png',
    'assets/templates/template4.png',
    'assets/templates/template5.png',
    'assets/templates/template6.png',
  ]; // List to store template paths
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    // Fetch template paths when the screen initializes
  }

  // Future<void> _fetchTemplates() async {
  //   try {
  //     setState(() {
  //       isLoading = true; // Show loading indicator
  //     });

  //     final response = await http.get(
  //       Uri.parse('http://localhost:8000/templates'),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       print("Data : " + data.toString());
  //       // Check if 'templates_links' key exists and its value is not null
  //       if (data.containsKey('templates_links') &&
  //           data['templates_links'] != null) {
  //         setState(() {
  //           templates = List<String>.from(data['templates_links']);
  //           isLoading = false; // Hide loading indicator
  //         });
  //       } else {
  //         print('Key "templates_links" is null or missing in the response.');
  //         setState(() {
  //           isLoading = false; // Hide loading indicator
  //         });
  //       }
  //     } else {
  //       print('Failed to fetch templates. Status code: ${response.statusCode}');
  //       setState(() {
  //         isLoading = false; // Hide loading indicator
  //       });
  //     }
  //   } catch (e) {
  //     print('Error fetching templates: $e');
  //     setState(() {
  //       isLoading = false; // Hide loading indicator
  //     });
  //   }
  // }

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
                            primary: _currentIndex == i
                                ? Colors.grey[800] // Selected button color
                                : Colors.transparent, // Unselected button color
                            onPrimary: Colors.white, // Text color
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
                      _currentIndex = index;
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
                            _buildImageContainer(
                                context, templates[startIndex]),
                          if (endIndex < templates.length)
                            _buildImageContainer(context, templates[endIndex]),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
    final apiUrl = 'http://localhost:8000/color_change_template';

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

    // try {
    //   Map<String, dynamic> result = await colorChangeTemplate();

    //   List RGBList = result['RGBValues'];
    //   List TextList = result['TextColors'];

    //   Navigator.pop(context);

    //   // Determine which image was clicked and navigate accordingly
    //   // if (imagePath == borderImages[0]) {
    //   //   Navigator.pushReplacement(
    //   //     context,
    //   //     MaterialPageRoute(builder: (context) {
    //   //       return ImageEditor(
    //   //         RGBValues: RGBList,
    //   //         TextValues: TextList,
    //   //         profileURL: [profileURL],
    //   //         imagePath: imagePathURL,
    //   //         fullname: fullname,
    //   //         position: position,
    //   //       );
    //   //     }),
    //   //   );
    //     // } else if (imagePath == borderImages[1]) {
    //     //   Navigator.pushReplacement(
    //     //     context,
    //     //     MaterialPageRoute(builder: (context) {
    //     //       return ImageEditor2(
    //     //         RGBValues: RGBList,
    //     //         TextValues: TextList,
    //     //         profileURL: [profileURL],
    //     //         imagePath: imagePathURL,
    //     //         fullname: fullname,
    //     //         position: position,
    //     //       );
    //     //     }),
    //     //   );
    //     // } else if (imagePath == borderImages[2]) {
    //     //   Navigator.pushReplacement(
    //     //     context,
    //     //     MaterialPageRoute(builder: (context) {
    //     //       return ImageEditor3(
    //     //         RGBValues: RGBList,
    //     //         TextValues: TextList,
    //     //         profileURL: [profileURL],
    //     //         imagePath: imagePathURL,
    //     //         fullname: fullname,
    //     //         position: position,
    //     //       );
    //     //     }),
    //     //   );
    //     // } else if (imagePath == borderImages[3]) {
    //     //   Navigator.pushReplacement(
    //     //     context,
    //     //     MaterialPageRoute(builder: (context) {
    //     //       return ImageEditor4(
    //     //         RGBValues: RGBList,
    //     //         TextValues: TextList,
    //     //         profileURL: [profileURL],
    //     //         imagePath: imagePathURL,
    //     //         fullname: fullname,
    //     //         position: position,
    //     //       );
    //     //     }),
    //     //   );
    //     // } else if (imagePath == borderImages[4]) {
    //     //   Navigator.pushReplacement(
    //     //     context,
    //     //     MaterialPageRoute(builder: (context) {
    //     //       return ImageEditor6(
    //     //         RGBValues: RGBList,
    //     //         TextValues: TextList,
    //     //         profileURL: [profileURL],
    //     //         imagePath: imagePathURL,
    //     //         fullname: fullname,
    //     //         position: position,
    //     //       );
    //     //     }),
    //     //   );
    //   }
    // } catch (error) {
    //   Navigator.pop(context);

    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Error: $error'),
    //     ),
    //   );
    // }
  }

  Widget _buildImageContainer(BuildContext context, String imagePath) {
    return GestureDetector(
      onTap: () => _onContainerTap(context, imagePath),
      child: Container(
        height: 150,
        width: 150,
        margin: EdgeInsets.symmetric(horizontal: 8), // Adjust spacing here
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: Image.asset(imagePath).image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
