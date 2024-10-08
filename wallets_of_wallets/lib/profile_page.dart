// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api, avoid_print, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstly/Cards/card.dart';
import 'package:firstly/Cards/cardManager.dart';
import 'package:firstly/cards_page.dart';
import 'package:firstly/data_base_manager.dart';
import 'package:firstly/main_page.dart';
import 'package:firstly/profile_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_page.dart'; // Import your login page widget

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color customColor = Color(0xFF0A5440);

  String selectedUser = ''; // Default user
  double balance = 0.00;

  // Get the current user's email
  String? userEmail = FirebaseAuth.instance.currentUser!.email;

  String helperText ="* This is the profile page.\n"+
    "* You can see your balance, name, surname and photo here.\n"+
    "* You can also withdraw or deposit money to your account.\n" + 
    "* You can also see your cards and add new cards by clicking the My Cards button.\n"+
    "* You can also change your information by clicking the Settings button.\n"+
    "* You can logout from the app by clicking the logout button on the top right corner.";

  TextEditingController card = TextEditingController();
  TextEditingController amount = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch user data when the page is initialized
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      // Retrieve user data from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail)
          .get();

      // Extract user information
      if (userSnapshot.exists) {
        setState(() {
          // Update selected user's name and surname
          selectedUser = '${userSnapshot['name']} ${userSnapshot['surname']}';
          // Update balance
          balance = userSnapshot['balance'].toDouble();
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _fetchUserBalance() async {
    try {
      // Retrieve user data from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail)
          .get();

      // Extract user information
      if (userSnapshot.exists) {
        setState(() {
          // Update balance
          balance = userSnapshot['balance'].toDouble();
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.help,
            color: customColor, // Replace with your desired color
            size: 40, // Replace with your desired size
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: customColor, // Replace with your desired color
              size: 40, // Replace with your desired size
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Log out'),
                    content: Text('Are you want to log out?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          AuthenticationManager.logout(context);
                          // Navigate to the login page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginPage()),
                          );
                        },
                        child: Text('Log Out'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 65,
              //if userPhoto is empty String, show default image
              backgroundImage: userPhoto!.isEmpty
                  ? AssetImage('assets/anonymous.png') as ImageProvider<Object>
                  : NetworkImage(userPhoto!),
            ),
            SizedBox(height: 20),
            Text(
              '₺$balance',
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: customColor),
            ),
            SizedBox(height: 20),
            Text(
              '$selectedUser',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: customColor),
            ),
            SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(100, 150, 150, 150),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            15.0), // Adjust the radius for curved edges
                        borderSide:
                            BorderSide.none, // Set the border color to gray
                      ),
                    ),
                    hint: Text('Select card'),
                    items: [
                      if (CardManager.cards.isEmpty)
                        DropdownMenuItem<String>(
                          value: 'No card found',
                          child: Text('No card found'),
                        ),
                      for (UserCard card in CardManager.cards)
                        DropdownMenuItem<String>(
                          value: card.cardCardName,
                          child: Text(card.cardCardName),
                        ),
                    ],
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(
                        () {
                          card.text = value!;
                        },
                      );
                    },
                    isExpanded: true)),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: amount,
                keyboardType: TextInputType.number, // Open number keyboard
                inputFormatters: <TextInputFormatter>[
                  //only 2 digits after the decimal point
                  FilteringTextInputFormatter.allow(RegExp(
                      r'^\d+\.?\d{0,2}') //only 2 digits after the decimal point
                  ),
                ],
                decoration: InputDecoration(
                  labelText: 'Amount',
                  filled: true,
                  fillColor: Color.fromARGB(100, 150, 150, 150),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        15.0), // Adjust the radius for curved edges
                    borderSide: BorderSide.none, // Set the border color to gray
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 300.0, // Adjust the width as needed
                child: ElevatedButton(
                  onPressed: () async {
                    // Yavuz : async added because we are using await in the function
                    //check if card selected using textEditingController
                    if (card.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select a card'),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                      return;
                    }

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Withdraw Money'),
                          content: Text('Are you sure you want to withdraw?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async{
                                double withdrawalAmount = double.parse(amount.text);
                                await UsersTableManager.updateUserBalance(context, userEmail!, withdrawalAmount, false);
                                _fetchUserBalance();
                                Navigator.pop(context);
                              },
                              child: Text('Withdraw'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor, // Set the button color
                    minimumSize:
                        Size(120.0, 40.0), // Set the minimum size of the button
                  ),
                  child: Text(
                    'Withdraw',
                    style: TextStyle(
                      color: Colors.white, // Set the text color
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 300.0, // Adjust the width as needed
                child: ElevatedButton(
                  onPressed: () async {
                    
                    // Yavuz: async added because we are using await in the function
                    //check if card selected using textEditingController
                    if (card.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select a card'),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                      return;
                    }

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Deposit Money'),
                          content: Text('Are you sure you want to deposit?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async{
                                double depositAmount = double.parse(amount.text);
                                await UsersTableManager.updateUserBalance(context, userEmail!, depositAmount, true);
                                _fetchUserBalance();
                                Navigator.pop(context);
                              },
                              child: Text('Deposit'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor, // Set the button color
                    minimumSize:
                        Size(120.0, 40.0), // Set the minimum size of the button
                  ),
                  child: Text(
                    'Deposit',
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30.0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card, size: 30.0),
            label: 'My Cards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 30.0),
            label: 'Settings',
          ),
        ],

        selectedItemColor: customColor, // Set color for selected icon
        selectedFontSize:
            double.parse('14.5'), // Set font size for selected label

        showUnselectedLabels: true,
        unselectedItemColor: customColor, // Set color for unselected icon
        unselectedFontSize:
            double.parse('14.5'), // Set font size for unselected label
        unselectedLabelStyle:
            TextStyle(color: customColor), // Set color for unselected label

        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MainPage()), // Navigate to MainPage
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CardsList()), // Navigate to MainPage
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileSettings()), // Navigate to MainPage
              );
              break;
          }
        },
      ),
    );
  }
}
