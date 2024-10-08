// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:firstly/create_wallet_page.dart';
import 'package:firstly/data_base_manager.dart';
import 'package:flutter/material.dart';
import 'package:firstly/main_page.dart'; // Replace this import with your actual main page import

class JoinWalletScreen extends StatelessWidget {

  final TextEditingController walletIDController = TextEditingController();

  final Color customColor = Color(0xFF0A5440);

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
            TextField(
              maxLength: 6,
              controller: walletIDController,
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Join To Card'),
                          content: Text('Are you sure you want to join to ${walletIDController.text}?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                if (WalletsTableManager.joinWallet(context, walletIDController.text) == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully joined the wallet',textAlign: TextAlign.center)));
                                }
                              },
                              child: Text('Join'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor, // Set the button color
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
            icon: Icon(Icons.home, size: 30.0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group, size: 30.0),
            label: 'Create Wallet',
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
                MaterialPageRoute(builder: (context) => CreateWalletScreen()), // Replace MainPage() with your main page widget
              );
              break;
          }
        },
      ),
    );
  }
}
