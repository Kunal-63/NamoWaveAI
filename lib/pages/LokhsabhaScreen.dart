import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
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
  List<String> templates = []; // List to store template paths
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    // Fetch template paths when the screen initializes
    _fetchTemplates();
  }

  Future<void> _fetchTemplates() async {
    try {
      setState(() {
        isLoading = true; // Show loading indicator
      });

      final response = await http.get(
        Uri.parse('http://192.168.1.3:8000/templates'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Data : " + data.toString());
        // Check if 'templates_links' key exists and its value is not null
        if (data.containsKey('templates_links') &&
            data['templates_links'] != null) {
          setState(() {
            templates = List<String>.from(data['templates_links']);
            isLoading = false; // Hide loading indicator
          });
        } else {
          print('Key "templates_links" is null or missing in the response.');
          setState(() {
            isLoading = false; // Hide loading indicator
          });
        }
      } else {
        print('Failed to fetch templates. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false; // Hide loading indicator
        });
      }
    } catch (e) {
      print('Error fetching templates: $e');
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
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
              Column(
                children: [
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
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
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
                                _buildImageContainer(
                                    context, templates[endIndex]),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageContainer(BuildContext context, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BorderScreen(
              fullname: widget.fullname,
              profileURL: widget.profileURL,
              imagePathURL: imagePath,
              phoneNumber: widget.phoneNumber,
              position: widget.position,
            ),
          ),
        );
      },
      child: Container(
        height: 150,
        width: 150,
        margin: EdgeInsets.symmetric(horizontal: 8), // Adjust spacing here
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: Image.network(imagePath).image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
