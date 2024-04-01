// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'login_page.dart'; // Import your login page widget

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String selectedUser = 'John Doe'; // Default user

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
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
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
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _showBottomSheet(context);
            },
            child: Text('Select User'),
          ),
          SizedBox(height: 20),
          Text(
            'Selected User: $selectedUser',
            style: TextStyle(fontSize: 20),
          ),
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
                child: Text('Button 1'),
              ),
              SizedBox(height: 10), // Add spacing between the buttons
              ElevatedButton(
                onPressed: () {
                  // Add functionality for button 2
                },
                child: Text('Button 2'),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.blue,
        currentIndex: 0,
        onTap: (index) {
          // Add functionality for bottom navigation
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
