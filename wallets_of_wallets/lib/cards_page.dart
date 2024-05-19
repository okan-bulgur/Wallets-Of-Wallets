// ignore_for_file: prefer_const_constructors

import 'package:firstly/Cards/card.dart';
import 'package:firstly/add_card_page.dart';
import 'package:firstly/data_base_manager.dart';
import 'package:firstly/main_page.dart';
import 'package:firstly/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firstly/Cards/cardManager.dart';

class CardsList extends StatelessWidget {

  final Color customColor = Color(0xFF0A5440);

  String helperText = "* This page displays all the cards that you have added to your account.\n" +
    "* You can also delete a card by clicking on the card and then clicking on the 'Remove Card' button.\n" +
    "* To add a new card, click on the 'Add Card' button at the bottom of the screen.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.help,
            color: customColor,
            size: 40,
          ),
          onPressed: () {
            showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Help"),
                      content: Text(helperText),
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
        ),
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
      body: SingleChildScrollView(
      
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40.0),
              Center(
                child: Text(
                  'My Cards',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: customColor,
                  ),
                ),
              ),

              SizedBox(height: 20.0),
              for (int index = 0; index < CardManager.cards.length; index++)
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              showSlideWindow(context, CardManager.cards[index]);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: customColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Container(
                              height: 70.0,
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    CardManager.cards[index].cardCardName,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30.0), // Change the size value to your desired size
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card, size: 30.0), // Change the size value to your desired size
            label: 'Add Card',
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
                MaterialPageRoute(
                  builder: (context) => AddCard()
                ),
              );
              break;
          }
        },
      ),
    );
  }
  void showSlideWindow(BuildContext context, UserCard card) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: customColor, // Change the background color to blue
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  Text(
                    card.cardCardName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30), // Add spacing between buttons
                  SizedBox(
                    width: 250.0, // Adjust the width as needed
                    child: ElevatedButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Card'),
                              content: Text('Are you sure you want to delete the card?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async{
                                    await CardsTableManager.deleteCard(context, card.cardID);
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfilePage()
                                      ),
                                    );
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(120.0, 50.0),
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Remove Card',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}