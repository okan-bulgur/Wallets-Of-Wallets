// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:firstly/Wallets/wallet.dart';
import 'package:firstly/data_base_manager.dart';
import 'package:firstly/create_wallet_page.dart';
import 'package:firstly/wallet_page_admin.dart';
import 'package:firstly/wallet_page_member.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  CarouselController buttonCarouselController = CarouselController();
  final Color customColor = Color(0xFF0A5440);
  int currentIndex = 0;
  List<Wallet>? list_of_wallets;

  @override
  void initState() {
    super.initState();
    initializeWallets();
  }

  void initializeWallets() async {
    List<Wallet>? wallets = await WalletsTableManager.getWalletsOfUser(userEmail!);
    setState(() {
      list_of_wallets = wallets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallets of Wallets',
          style: TextStyle(
              fontSize: 30.0, fontWeight: FontWeight.bold, color: customColor),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.person,
              color: customColor, // Replace with your desired color
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
                if (list_of_wallets != null && list_of_wallets!.isNotEmpty)
                  for (int wallet = 0; wallet < list_of_wallets!.length; wallet++)
                    GestureDetector(
                      onTap: () async {
                        WalletsTableManager.selectedWallet = list_of_wallets![wallet];

                        if (await WalletsTableManager.isUserAdminOfWallet(WalletsTableManager.selectedWallet!.walletId)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WalletPageAdmin(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WalletPageMember(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: list_of_wallets![wallet].walletColor
                              as Color?,
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
                          list_of_wallets![wallet].walletName,
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
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (list_of_wallets!.isNotEmpty)
                    Text(
                      '${list_of_wallets![currentIndex].walletName}',
                      style: TextStyle(
                        color: customColor,
                      ),
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
                        for (int wallet = 0; wallet < list_of_wallets!.length; wallet++)
                          Container(
                            width: 12.0,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == wallet
                                  ? customColor
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
                  if (list_of_wallets!.isNotEmpty)
                    Text(
                      'ID: ${list_of_wallets![currentIndex].walletId}',
                      style: TextStyle(
                        color: customColor,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: FloatingActionButton(
              onPressed: () {
                // Add functionality for the help button
                // This could be a dialog or a new screen displaying information about the application
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Help"),
                      content: Text("To see your profile/balance click on the button top right.\nTo create/join wallet click on the button bottom right.\nTo view wallet click on the wallet square center of the screen."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Close"),
                        ),
                      ],
                    );
                  },
                );
              },
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              child: Icon(
                Icons.help,
                size: 40, // Adjust size of the icon
                color: customColor,
              ),
            ),
          ),
          
          FloatingActionButton(
            onPressed: () {
              // Add functionality for the existing floating action button
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
              color: customColor,
            ),
          ),
           // Add spacing between the buttons
        ],
      ),
    );
  }
}