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
const List<String> list = <String>['Card 1', 'Card 2', 'Card 3', 'Card 4'];

String dropdownValue = list.first; //change this to the last selected

class _ProfilePageState extends State<ProfilePage> {
  final Color customColor = Color(0xFF0A5440);

  String selectedUser = 'John Doe'; // Default user
  double balance = 0.00;

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
            radius: 65,
            backgroundImage: AssetImage('assets/pp_1.png'), // Add your avatar image
          ),
          SizedBox(height: 20),
          Text(
              '₺$balance',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: customColor
              ),
          ),
          SizedBox(height: 20),
          Text(
            '$selectedUser',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: customColor
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
          DropdownButtonFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(100, 150, 150, 150),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0), // Adjust the radius for curved edges
                  borderSide:
                  BorderSide.none, // Set the border color to gray
                ),
              ),
              value: dropdownValue,
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
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                filled: true,
                fillColor: Color.fromARGB(100, 150, 150, 150),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0), // Adjust the radius for curved edges
                  borderSide:
                  BorderSide.none, // Set the border color to gray
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 300.0, // Adjust the width as needed
              child: ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor, // Set the button color
                  minimumSize: Size(120.0, 40.0), // Set the minimum size of the button
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
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor, // Set the button color
                  minimumSize: Size(120.0, 40.0), // Set the minimum size of the button
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
