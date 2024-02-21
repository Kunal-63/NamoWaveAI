import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _currentIndex = 0;
  final List<String> images = [
    'assets/landing1.png',
    'assets/landing2.png',
    'assets/landing3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Expanded(
            child: CarouselSlider.builder(
              itemCount: images.length,
              options: CarouselOptions(
                height: double.infinity,
                aspectRatio: 16 / 9,
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
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          SizedBox(height: 20.0),
          Positioned(
            bottom: 80.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _currentIndex == index ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(
                    208, 226, 240, 1), // Change the color to your preference
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Get Started!',
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
