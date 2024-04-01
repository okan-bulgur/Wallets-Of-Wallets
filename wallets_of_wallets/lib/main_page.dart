import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'profile_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CarouselController buttonCarouselController = CarouselController();

  int currentIndex = 0;
  List<List<Object>> listOfWallets = [
    ['Wallet_1', Color.fromARGB(255, 54, 106, 57)],
    ['Wallet_2', Color.fromARGB(255, 228, 138, 35)],
    ['Wallet_3', Color.fromARGB(255, 187, 9, 92)],
    ['Wallet_4', Color.fromARGB(255, 12, 175, 175)]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wallets of Wallets',
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 54, 106, 57)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.person,
              color: Color.fromARGB(255, 54, 106, 57), // Replace with your desired color
              size: 40, // Replace with your desired size
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CarouselSlider(
              items: [
                for(int wallet = 0; wallet < listOfWallets.length; wallet++)
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: listOfWallets[wallet][1] as Color?,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      listOfWallets[wallet][0].toString(),
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
              ], // Add your items here
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                enlargeCenterPage: true,
                onPageChanged: (int index, CarouselPageChangedReason reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${listOfWallets[currentIndex][0]}',
                ),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 50.0,
                    right: 50.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for(int wallet = 0; wallet < listOfWallets.length; wallet++)
                        Container(
                          width: 12.0,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentIndex == wallet
                                ? Color.fromARGB(255, 54, 106, 57)
                                : Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                Text(
                  'id of ${listOfWallets[currentIndex][0]}',
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality for the plus button
        },
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: Icon(
          Icons.add,
          size: 50, // Adjust size of the icon
          color: Color.fromARGB(255, 54, 106, 57),
        ),
      ),
    );
  }
}