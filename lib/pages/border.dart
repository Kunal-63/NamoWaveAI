import 'package:flutter/material.dart';
import 'package:theog/pages/ImageEditor.dart';
// import 'package:theog/pages/LokhsabhaScreen.dart';

class BorderScreen extends StatelessWidget {
  final String imagePath;
  BorderScreen({Key? key, required this.imagePath}) : super(key: key);

  final List borderImages = [
    'assets/borders/template1.png',
    'assets/borders/template1.png',
    'assets/borders/template1.png',
    'assets/borders/template1.png',
    'assets/borders/template1.png',
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0.0,
          title: Text('Frames'),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: (borderImages.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    int startIndex = index * 2;
                    int endIndex = startIndex + 1;
                    return Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (startIndex < borderImages.length)
                              _buildImageContainer(
                                  context, borderImages[startIndex]),
                            if (endIndex < borderImages.length)
                              _buildImageContainer(
                                  context, borderImages[endIndex]),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
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
            builder: (context) => ImageEditor(
              imagePath: this.imagePath,
            ),
          ),
        );
      },
      child: Container(
        width: 150,
        height: 150,
        margin: EdgeInsets.symmetric(horizontal: 8),
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
