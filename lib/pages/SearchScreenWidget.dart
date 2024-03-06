import 'package:flutter/material.dart';
import 'package:theog/pages/LokhsabhaScreen.dart';
import 'package:theog/pages/HomeScreenWidget.dart';

class SearchScreen extends StatefulWidget {
  final String profileURL;
  const SearchScreen({
    Key? key,
    required this.profileURL,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List filteredLokhSabhaList = [];

  @override
  void initState() {
    super.initState();
    filteredLokhSabhaList = HomeScreenWidget.LokhSabhaList;
  }

  void filterLokhSabhas(String query) {
    setState(() {
      filteredLokhSabhaList = HomeScreenWidget.LokhSabhaList.where((lokSabha) =>
          lokSabha.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(12, 12, 12, 0.95),
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: searchController,
                  onChanged: filterLokhSabhas,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(100, 100, 100, 0.5),
                    filled: true,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: 'Enter keyword you want to search for',
                    hintStyle: TextStyle(
                      color: Colors.grey[300],
                    ),
                    labelText: 'Search',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              searchController.text.isEmpty
                  ? Container()
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: filteredLokhSabhaList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LokhSabhaScreen(
                                    profileURL: widget.profileURL,
                                    lokhSabhaName: filteredLokhSabhaList[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/places/${filteredLokhSabhaList[index].toUpperCase()}.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Text(''),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
