// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:firstly/Wallets/walletManager.dart';

import 'package:firstly/create_wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'profile_page.dart';
import 'wallet_page_admin.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CarouselController buttonCarouselController = CarouselController();

  int currentIndex = 0;

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
        automaticallyImplyLeading: false,
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
                if (WalletManager.wallets.isNotEmpty)
                  for(int wallet = 0; wallet < WalletManager.wallets.length; wallet++)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WalletPageAdmin(),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: WalletManager.wallets[wallet].walletColor as Color?,
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
                          WalletManager.wallets[wallet].walletName,
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
            Padding(
              padding: const EdgeInsets.only(left: 50.0 , right: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (WalletManager.wallets.isNotEmpty)
                    Text(
                      '${WalletManager.wallets[currentIndex].walletName}',
                    ),
                  SizedBox(width: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 50.0,
                      right: 50.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for(int wallet = 0; wallet < WalletManager.wallets.length; wallet++)
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
                  if (WalletManager.wallets.isNotEmpty)
                    Text(
                      'id: ${WalletManager.wallets[currentIndex].walletId}',
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateWalletScreen()),
            );
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