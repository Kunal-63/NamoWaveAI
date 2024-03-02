import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:theog/pages/LokhsabhaScreen.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    List LokhSabhaList = [
      'Ahmedabad',
      'Amreli',
      'Anand',
      'Banaskantha',
      'Bharuch',
      'Bhavnagar',
      'Dahod',
      'Dang',
      'Gandhinagar',
      'Jamnagar',
      'Junagadh',
      'Kheda',
      'Kutch',
      'Mehsana',
      'Narmada',
      'Navsari',
      'Panchmahal',
      'Patan',
      'Porbandar',
      'Rajkot',
      'Sabarkantha',
      'Surat',
      'Surendranagar',
      'Tapi',
      'Vadodara',
      'Valsad'
    ];

    final List<String> images = [
      'assets/home/1.jpg',
      'assets/home/2.jpg',
      'assets/home/3.jpg',
    ];
    int _currentIndex = 0;

    return SingleChildScrollView(
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Lokhsabha',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ]),
              Column(
                children: List.generate(
                  LokhSabhaList.length ~/
                      2, // Adjust this to display half the Lokh Sabhas
                  (index) {
                    int containerNumber = index * 2;
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LokhSabhaScreen(
                                      lokhSabhaName:
                                          LokhSabhaList[containerNumber],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '${LokhSabhaList[containerNumber]}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LokhSabhaScreen(
                                      lokhSabhaName:
                                          LokhSabhaList[containerNumber + 1],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '${LokhSabhaList[containerNumber + 1]}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
