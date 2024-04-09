// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api

import 'package:firstly/cards_page.dart';
import 'package:firstly/main_page.dart';
import 'package:firstly/profile_settings_page.dart';
import 'package:flutter/material.dart';
import 'login_page.dart'; // Import your login page widget

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

String dropdownValue = list.first; //change this to the last selected

class _ProfilePageState extends State<ProfilePage> {
  final Color customColor = Color(0xFF0A5440);

  String selectedUser = 'John Doe'; // Default user
  double balance = 5000.00;

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
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: customColor, // Replace with your desired color
              size: 40, // Replace with your desired size
            ),
            onPressed: () {
              // Navigate to the login page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage('assets/emenike.png'), // Add your avatar image
          ),
          SizedBox(height: 40),
          Text(
            '\$$balance',
            style: TextStyle(fontSize: 40),
          ),
          SizedBox(height: 20),
          Text(
            'Selected User: $selectedUser',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
          DropdownButton(value: dropdownValue,
              items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                },);
              },
              isExpanded: true)),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Enter something',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add functionality for button 1
                },
                child: Text('Withdraw'),
              ),
              SizedBox(height: 10), // Add spacing between the buttons
              ElevatedButton(
                onPressed: () {
                  // Add functionality for button 2
                },
                child: Text('Deposit'),
              ),
            ],
          ),
        ],
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
                MaterialPageRoute(builder: (context) => CardsList()), // Navigate to MainPage
              );
              break;
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileSettings()), // Navigate to MainPage
              );
              break;
          }
        },
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('John Doe'),
                onTap: () {
                  setState(() {
                    selectedUser = 'John Doe';
                  });
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                title: Text('Jane Smith'),
                onTap: () {
                  setState(() {
                    selectedUser = 'Jane Smith';
                  });
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                title: Text('Alice Johnson'),
                onTap: () {
                  setState(() {
                    selectedUser = 'Alice Johnson';
                  });
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
