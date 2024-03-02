import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LokhSabhaScreen extends StatefulWidget {
  final String lokhSabhaName;

  LokhSabhaScreen({required this.lokhSabhaName});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(12, 12, 12, 1),
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
        title: Center(
          child: Text(
            '${widget.lokhSabhaName}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
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
                    height: MediaQuery.of(context).size.height * 0.5,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/imageEditor');
                      },
                      child: Image.asset(
                        'assets/treding1.jpg',
                        width: 150,
                        height: 150,
                      ),
                    ),
                    Image.asset(
                      'assets/trending2.jpg',
                      width: 150,
                      height: 150,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/trending3.jpg',
                      width: 150,
                      height: 150,
                    ),
                    Image.asset(
                      'assets/trending4.jpg',
                      width: 150,
                      height: 150,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
