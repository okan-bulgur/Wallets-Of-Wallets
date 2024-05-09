// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:firstly/data_base_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'data_base_manager.dart';
import 'package:firstly/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firstly/main_page.dart'; // Replace this import with your actual main page import

/* 
-----------------------------------------------------------------------------------------
*****Bu kısımdaki kod kartları database eklemeden önceki kısmın kodları (silinebilir)****
-----------------------------------------------------------------------------------------

class AddCard extends StatelessWidget {

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

        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: 40.0),
            Text(
              'Add Card',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: customColor,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '! Please add a debit or credit card to complete your purchase.',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.normal,
                color: customColor,
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'owner name',
                filled: true,
                fillColor: Color.fromARGB(100, 150, 150, 150),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      15.0), // Adjust the radius for curved edges
                  borderSide:
                  BorderSide.none, // Set the border color to gray
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'card number',
                filled: true,
                fillColor: Color.fromARGB(100, 150, 150, 150),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      15.0), // Adjust the radius for curved edges
                  borderSide:
                  BorderSide.none, // Set the border color to gray
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'MM/YY',
                    filled: true,
                    fillColor: Color.fromARGB(100, 150, 150, 150),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          15.0), // Adjust the radius for curved edges
                      borderSide:
                      BorderSide.none, // Set the border color to gray
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'CVC',
                    filled: true,
                    fillColor: Color.fromARGB(100, 150, 150, 150),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          15.0), // Adjust the radius for curved edges
                      borderSide:
                      BorderSide.none, // Set the border color to gray
                    ),
                  ),
                ),
              )
            ]),
            SizedBox( height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                          maxLength: 10,
                          decoration: InputDecoration(
                            labelText: 'card name',
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
                        'Add',
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
            SizedBox(height: 20),
            ]
        )

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
*/

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();
  final TextEditingController cardNameController = TextEditingController();

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

        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: 40.0),
            Text(
              'Add Card',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: customColor,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '! Please add a debit or credit card to complete your purchase.',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.normal,
                color: customColor,
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: ownerController,
              decoration: InputDecoration(
                labelText: 'owner name',
                filled: true,
                fillColor: Color.fromARGB(100, 150, 150, 150),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      15.0), // Adjust the radius for curved edges
                  borderSide:
                  BorderSide.none, // Set the border color to gray
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: cardNumberController,
              decoration: InputDecoration(
                labelText: 'card number',
                filled: true,
                fillColor: Color.fromARGB(100, 150, 150, 150),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      15.0), // Adjust the radius for curved edges
                  borderSide:
                  BorderSide.none, // Set the border color to gray
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Expanded(
                child: TextField(
                  controller: expiryDateController,
                  decoration: InputDecoration(
                    labelText: 'MM/YY',
                    filled: true,
                    fillColor: Color.fromARGB(100, 150, 150, 150),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          15.0), // Adjust the radius for curved edges
                      borderSide:
                      BorderSide.none, // Set the border color to gray
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: cvcController,
                  decoration: InputDecoration(
                    labelText: 'CVC',
                    filled: true,
                    fillColor: Color.fromARGB(100, 150, 150, 150),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          15.0), // Adjust the radius for curved edges
                      borderSide:
                      BorderSide.none, // Set the border color to gray
                    ),
                  ),
                ),
              )
            ]),
            SizedBox( height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                          controller: cardNameController,
                          maxLength: 20,
                          decoration: InputDecoration(
                            labelText: 'card name',
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
                      onPressed:() {
                        CardsTableManager.addCard(
                          cvcController.text,
                          cardNameController.text,
                          cardNumberController.text,
                          expiryDateController.text,
                          ownerController.text,
                          FirebaseAuth.instanceFor(app: app).currentUser!.email.toString(),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage()),
                        );
                      },
                      child: Text(
                        'Add',
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
            SizedBox(height: 20),
            ]
        )

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

/*
  @override
  void dispose() {
    _ownerController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvcController.dispose();
    _cardNameController.dispose();
    super.dispose();
  }
  */
}
