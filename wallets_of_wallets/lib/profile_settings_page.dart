import 'package:firstly/create_wallet_page.dart';
import 'package:firstly/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firstly/main_page.dart'; // Replace this import with your actual main page import

class ProfileSettings extends StatelessWidget {

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
              maxLength: 50,
              decoration: InputDecoration(
                labelText: 'First Name',
                filled: true,
                fillColor: Color.fromARGB(100, 150, 150, 150),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              maxLength: 50,
              decoration: InputDecoration(
                labelText: 'Last Name',
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()), // Navigate to MainPage
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor, // Set the button color
                    minimumSize: Size(120.0, 40.0), // Set the minimum size of the button
                  ),
                  child: Text(
                    'Set',
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
            icon: Icon(Icons.close),
            label: 'Cancel',
          ),
        ],
        selectedIconTheme: IconThemeData(color: customColor), // Set color for selected icon
        unselectedIconTheme: IconThemeData(color: customColor), // Set color for unselected icon
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
              MaterialPageRoute(builder: (context) => ProfilePage()), // return to the profile page
            );
          }
        },
      ),
    );
  }
}
