import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
        title: Text('Main Page'),
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
                  child: Text('Wallet_1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for the wallet button
                  },
                  child: Text('Wallet_2'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for the wallet button
                  },
                  child: Text('Wallet_3'),
                ),
              ], // Add your items here
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 2.0,
                initialPage: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => buttonCarouselController.previousPage(
                      duration: Duration(milliseconds: 300), curve: Curves.linear),
                  child: Text('←'),
                ),
                ElevatedButton(
                  onPressed: () => buttonCarouselController.nextPage(
                      duration: Duration(milliseconds: 300), curve: Curves.linear),
                  child: Text('→'),
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