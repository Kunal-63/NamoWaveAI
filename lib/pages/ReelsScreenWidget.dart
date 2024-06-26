import 'package:flutter/material.dart';
import 'package:theog/pages/LokhsabhaScreen.dart';
import 'package:theog/pages/ReelsLokhsabha.dart';
// import 'package:theog/pages/ReelsLokhsabha.dart';
// import 'package:theog/pages/ReelsScreen/ReelsLokhsabha.dart';
// import 'package:carousel_slider/carousel_slider.dart';

class ReelsScreenWidget extends StatefulWidget {
  final String profileURL;
  final String phoneNumber;
  final String fullname;
  final String position;
  const ReelsScreenWidget({
    super.key,
    required String backgroundImage,
    required this.profileURL,
    required this.phoneNumber,
    required this.fullname,
    required this.position,
  });

  static List LokhSabhaImages = [
    'assets/places/AHMEDABAD.png',
    'assets/places/AMRELI.png',
    'assets/places/ANAND.png',
    'assets/places/BANASKANTHA.png',
    'assets/places/BHARUCH.png',
    'assets/places/BHAVNAGAR.png',
    'assets/places/DAHOD.png',
    'assets/places/GANDHINAGAR.png',
    'assets/places/JAMNAGAR.png',
    'assets/places/JUNAGADH.png',
    'assets/places/KHEDA.png',
    'assets/places/KACHCHH.png',
    'assets/places/MEHSANA.png',
    'assets/places/NAVSARI.png',
    'assets/places/PATAN.png',
    'assets/places/PORBANDAR.png',
    'assets/places/RAJKOT.png',
    'assets/places/SABARKANTHA.png',
    'assets/places/SURAT.png',
    'assets/places/SURENDRANAGAR.png',
    'assets/places/BARDOLI.png',
    'assets/places/VADODARA.png',
    'assets/places/VALSAD.png'
  ];
  static List LokhSabhaList = [
    'Ahmedabad',
    'Amreli',
    'Anand',
    'Banaskantha',
    'Bharuch',
    'Bhavnagar',
    'Dahod',
    'Gandhinagar',
    'Jamnagar',
    'Junagadh',
    'Kheda',
    'Kachchh',
    'Mehsana',
    'Navsari',
    'Patan',
    'Porbandar',
    'Rajkot',
    'Sabarkantha',
    'Surat',
    'Surendranagar',
    'Bardoli',
    'Vadodara',
    'Valsad',
  ];

  @override
  State<ReelsScreenWidget> createState() => _ReelsScreenWidgetState();
}

class _ReelsScreenWidgetState extends State<ReelsScreenWidget> {
  final List LokhSabhaImages = [
    'assets/places/AHMEDABAD.png',
    'assets/places/AMRELI.png',
    'assets/places/ANAND.png',
    'assets/places/BANASKANTHA.png',
    'assets/places/BHARUCH.png',
    'assets/places/BHAVNAGAR.png',
    'assets/places/DAHOD.png',
    'assets/places/GANDHINAGAR.png',
    'assets/places/JAMNAGAR.png',
    'assets/places/JUNAGADH.png',
    'assets/places/KHEDA.png',
    'assets/places/KACHCHH.png',
    'assets/places/MEHSANA.png',
    'assets/places/NAVSARI.png',
    'assets/places/PATAN.png',
    'assets/places/PORBANDAR.png',
    'assets/places/RAJKOT.png',
    'assets/places/SABARKANTHA.png',
    'assets/places/SURAT.png',
    'assets/places/SURENDRANAGAR.png',
    'assets/places/BARDOLI.png',
    'assets/places/VADODARA.png',
    'assets/places/VALSAD.png'
  ];
  final List LokhSabhaList = [
    'Ahmedabad',
    'Amreli',
    'Anand',
    'Banaskantha',
    'Bharuch',
    'Bhavnagar',
    'Dahod',
    'Gandhinagar',
    'Jamnagar',
    'Junagadh',
    'Kheda',
    'Kachchh',
    'Mehsana',
    'Navsari',
    'Patan',
    'Porbandar',
    'Rajkot',
    'Sabarkantha',
    'Surat',
    'Surendranagar',
    'Bardoli',
    'Vadodara',
    'Valsad',
  ];

  @override
  Widget build(BuildContext context) {
    // final List<String> images = [
    //   'assets/home/home1.jpg',
    //   'assets/home/home2.jpg',
    //   'assets/home/home3.jpg',
    // ];
    int _currentIndex = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(12, 12, 12, 0),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'VIDEOS',
          style: TextStyle(
            fontSize: 24,
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(12, 12, 12, 0.95),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  // CarouselSlider.builder(
                  //   itemCount: images.length,
                  //   options: CarouselOptions(
                  //     height: MediaQuery.of(context).size.height * 0.5,
                  //     aspectRatio: 1 / 1,
                  //     viewportFraction: 1.0,
                  //     autoPlay: true,
                  //     enlargeCenterPage: false,
                  //     onPageChanged: (index, reason) {
                  //       setState(() {
                  //         _currentIndex = index;
                  //       });
                  //     },
                  //   ),
                  //   itemBuilder:
                  //       (BuildContext context, int index, int realIndex) {
                  //     return Image.asset(
                  //       images[index],
                  //       width: MediaQuery.of(context).size.width,
                  //       fit: BoxFit.cover,
                  //     );
                  //   },
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      'LOKHSABHA',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.white,
                            blurRadius: 1, // Set the blur radius here
                            offset: Offset(0, 0), // Set the shadow offset here
                          ),
                        ],
                      ),
                    )
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
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ReelsLokhsabhScreen(
                                          fullname: widget.fullname,
                                          phoneNumber: widget.phoneNumber,
                                          profileURL: widget.profileURL,
                                          lokhSabhaName:
                                              LokhSabhaList[containerNumber],
                                          position: widget.position,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            LokhSabhaImages[containerNumber]),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '',
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LokhSabhaScreen(
                                          fullname: widget.fullname,
                                          phoneNumber: widget.phoneNumber,
                                          profileURL: widget.profileURL,
                                          lokhSabhaName: LokhSabhaList[
                                              containerNumber + 1],
                                          position: widget.position,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(LokhSabhaImages[
                                            containerNumber + 1]),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '',
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LokhSabhaScreen(
                                  fullname: widget.fullname,
                                  phoneNumber: widget.phoneNumber,
                                  profileURL: widget.profileURL,
                                  lokhSabhaName: LokhSabhaList[22],
                                  position: widget.position,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(LokhSabhaImages[
                                    LokhSabhaImages.length - 1]),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                '',
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   width: 150,
                        //   height: 150,
                        //   child: Center(
                        //     child: Text(
                        //       '',
                        //     ),
                        //   ),
                        // ),
                      ]),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
