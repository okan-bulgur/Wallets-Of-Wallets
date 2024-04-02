// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, deprecated_member_use

import 'dart:math';

import 'package:firstly/Wallets/walletManager.dart';

import 'package:firstly/join_wallet_page.dart';
import 'package:firstly/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CreateWalletScreen extends StatefulWidget {
  @override
  _CreateWalletScreenState createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends State<CreateWalletScreen> {
  
  final Color customColor = Color(0xFF0A5440);

  late Color selectedColor; // Initialize late variable
  String walletName = '';
  String walletDescription = '';

  @override
  void initState() {
    super.initState();
    selectedColor = _getRandomColor(); // Initialize selectedColor with a random color
  }

  Color _getRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  void changeColor(Color color) {
    setState(() => selectedColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallets of Wallets',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: customColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Make corners curvy
                      ),
                      title: Text('Select a color'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: selectedColor,
                          onColorChanged: changeColor,
                          showLabel: true,
                          pickerAreaHeightPercent: 0.8,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            'SET COLOR',
                            style: TextStyle(
                              color: customColor, // Same color as title
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                width: double.infinity,
                height: 60.0,
                decoration: BoxDecoration(
                  color: selectedColor,
                  borderRadius: BorderRadius.circular(10.0), // Make corners curvy
                ),
              ),
            ),
            SizedBox(height: 40.0),
            TextField(
              maxLength: 30,
              decoration: InputDecoration(
                labelText: 'Set Wallet Name',
                filled: true,
                fillColor: Color.fromARGB(100, 150, 150, 150),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                walletName = value;
              },
            ),
            SizedBox(height: 20.0),
            TextField(
              maxLength: 200,
              decoration: InputDecoration(
                labelText: 'Set Description',
                filled: true,
                fillColor: Color.fromARGB(100, 150, 150, 150),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                walletDescription = value;
              },
            ),
            SizedBox(height: 20.0),
            Center(
              child: SizedBox(
                width: 120.0, // Adjust the width as needed
                child: ElevatedButton(
                  onPressed: () {
                    // Generate a wallet
                    WalletManager.generateWallet(selectedColor, walletName, walletDescription);
                    // Store the wallet or perform any other operations

                    // Navigate to MainPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor, // Set the button color
                    minimumSize: Size(120.0, 40.0), // Set the minimum size of the button
                  ),
                  child: Text(
                    'Create',
                    style: TextStyle(
                      color: Colors.white, // Set the text color
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30.0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group, size: 30.0),
            label: 'Join Wallet',
          ),
        ],

        selectedItemColor: customColor, // Set color for selected icon
        selectedFontSize: double.parse('14.5'), // Set font size for selected label
        
        showUnselectedLabels: true,
        unselectedItemColor: customColor, // Set color for unselected icon
        unselectedFontSize: double.parse('14.5'), // Set font size for unselected label
        unselectedLabelStyle: TextStyle(color: customColor), // Set color for unselected label
        
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()), // Navigate to MainPage
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JoinWalletScreen()), // Replace MainPage() with your main page widget
              );
              break;
          }
        },
      ),
    );
  }
}


