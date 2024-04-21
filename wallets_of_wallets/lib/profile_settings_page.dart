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
            GestureDetector(
              onTap: () {
              // Add your logic here to handle the avatar change
              },
              child: CircleAvatar(
                radius: 65,
                backgroundImage: AssetImage('assets/pp_1.png'), // Add your avatar image
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.add,
                      size: 40,
                      color: customColor,
                    ),
                  ),
              ),
            ),
            SizedBox(height: 40.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                          maxLength: 10,
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            filled: true,
                            fillColor: Color.fromARGB(100, 150, 150, 150),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                          ),
                          onChanged: (value) {
                          },
                        ),
                  ),

                  SizedBox(width: 10.0),
                  
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your logic here
                      },
                      child: Text(
                        'Set',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),

                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                          maxLength: 10,
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            filled: true,
                            fillColor: Color.fromARGB(100, 150, 150, 150),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                          ),
                          onChanged: (value) {
                          },
                        ),
                  ),

                  SizedBox(width: 10.0),
                  
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your logic here
                      },
                      child: Text(
                        'Set',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),

                ],
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
            icon: Icon(Icons.close, size: 30.0),
            label: 'Cancel',
          ),
        ],
        
        selectedItemColor: customColor, // Set color for selected icon
        selectedFontSize: double.parse('14.5'), // Set font size for selected label
        
        showUnselectedLabels: true,
        unselectedItemColor: customColor, // Set color for unselected icon
        unselectedFontSize: double.parse('14.5'), // Set font size for unselected label
        unselectedLabelStyle: TextStyle(color: customColor), // Set color for unselected label

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
