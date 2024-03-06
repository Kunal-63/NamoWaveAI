import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:theog/pages/border.dart';

class LokhSabhaScreen extends StatefulWidget {
  final String lokhSabhaName;
  final String profileURL;

  LokhSabhaScreen({
    required this.lokhSabhaName,
    required this.profileURL,
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

  final List<String> templates = [
    'assets/templates/template1.png',
    'assets/templates/template1.png',
    'assets/templates/template2.png',
    'assets/templates/template2.png',
    // Add more paths as needed
  ];

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
                        decoration: TextDecoration.none),
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
              profileURL: widget.profileURL,
              imagePath: imagePath,
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
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
