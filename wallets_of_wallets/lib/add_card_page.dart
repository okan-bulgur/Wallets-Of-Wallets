import 'package:firstly/cards_page.dart';
import 'package:firstly/data_base_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firstly/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firstly/main_page.dart'; // Replace this import with your actual main page import

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              SizedBox(height: 20),
              TextField(
                controller: cardNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16), // Adjusted for spaces
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    String newText = '';
                    for (int i = 0; i < newValue.text.length; i++) {
                      if (i % 4 == 0) {
                        newText += ' ';
                      }
                      newText += newValue.text[i];
                    }
                    return TextEditingValue(
                      text: newText,
                      selection: TextSelection.collapsed(offset: newText.length),
                    );
                  }),
                ],
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
              SizedBox(height: 20),
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: expiryDateController,
                    keyboardType: TextInputType.number,
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}(\/\d{0,2})?$')), // Allow only numbers 
                      LengthLimitingTextInputFormatter(5), // Limit length to 5 characters (XX/XX)
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        if (oldValue.text.length > newValue.text.length) {
                          return newValue;
                        }

                        // If the user is entering a value, then add a '/' after 2 characters
                        if (newValue.text.length == 2) {
                          return TextEditingValue(
                            text: '${newValue.text}/',
                            selection: TextSelection.collapsed(offset: newValue.selection.end+1),
                          );
                        }

                        return newValue;
                      }),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: cvcController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3), // Limit to 3 digits for CVC
                    ],
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
              SizedBox(height: 20),
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
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: ElevatedButton(
                      onPressed:() async{
                        if(cvcController.text == '' || cardNameController.text == '' || cardNumberController.text == '' || expiryDateController.text == '' || ownerController.text == '' || expiryDateController.text.length != 5) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Please fill in all fields.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }

                        if(cardNumberController.text.length != 20){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Card number must be 16 digits.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }

                        if(cvcController.text.length != 3){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('CVC must be 3 digits.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }

                        CardsTableManager.addCard(
                          context,
                          cvcController.text,
                          cardNameController.text,
                          cardNumberController.text,
                          expiryDateController.text,
                          ownerController.text,
                          FirebaseAuth.instanceFor(app: app).currentUser!.email.toString(),
                        );

                        //create pop up to show that the card is being created
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Creating Card'),
                              content: Text('Please wait while the card is being created'),
                            );
                          },
                        );

                        // I will use CardsList isCardChanged variable to synchronise the changes
                        while (!CardsList.isCardChanged) {
                          await Future.delayed(Duration(milliseconds: 500));
                        }
                        CardsList.isCardChanged = false;

                        await Navigator.push(
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
            ],
          ),
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
