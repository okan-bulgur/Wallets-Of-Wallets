// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:firstly/create_wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:firstly/main_page.dart'; // Replace this import with your actual main page import

class JoinWalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wallets of Wallets',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 54, 106, 57),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            TextField(
              maxLength: 50,
              decoration: InputDecoration(
                labelText: 'Enter Wallet ID',
                filled: true,
                fillColor: Color.fromARGB(100, 150, 150, 150),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Center(
              child: SizedBox(
                width: 120.0, // Adjust the width as needed
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality to join wallet
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 54, 106, 57), // Set the button color
                    minimumSize: Size(120.0, 40.0), // Set the minimum size of the button
                  ),
                  child: Text(
                    'Join',
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Create Wallet',
          ),
        ],
        selectedIconTheme: IconThemeData(color: Color.fromARGB(255, 54, 106, 57)), // Set color for selected icon
        unselectedIconTheme: IconThemeData(color: Color.fromARGB(255, 54, 106, 57)), // Set color for unselected icon
        onTap: (index) {
          // Add navigation logic based on the index of tapped item
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()), // Replace MainPage() with your main page widget
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateWalletScreen()), // Replace JoinWalletScreen() with your JoinWalletScreen widget
            );
          }
        },
      ),
    );
  }
}
