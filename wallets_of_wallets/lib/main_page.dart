import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'profile_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CarouselController buttonCarouselController = CarouselController();

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
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for the wallet button
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Adjust the border radius as desired
                    ),
                    backgroundColor: Color.fromARGB(255, 54, 106, 57),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    'Wallet_1',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20, // Replace with your desired font size
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for the wallet button
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Adjust the border radius as desired
                    ),
                    backgroundColor: Color.fromARGB(255, 8, 8, 92),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    'Wallet_2',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255), // Replace with your desired color
                      fontSize: 20,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for the wallet button
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Adjust the border radius as desired
                    ),
                    backgroundColor: Color.fromARGB(255, 255, 200, 82),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    'Wallet_3',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255), // Replace with your desired color
                      fontSize: 20, // Replace with your desired font size
                    ),
                  ),
                ),
              ], // Add your items here
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                enlargeCenterPage: true,
                onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
              ),
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

void callbackFunction(int index, CarouselPageChangedReason changeReason) {
  // Do something when page changes
  print('Current page is $index');
}