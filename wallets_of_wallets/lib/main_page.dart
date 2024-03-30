// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_super_parameters, prefer_const_literals_to_create_immutables

import 'package:firstly/profile_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wallets of Wallets',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 54, 106, 57)
          ),
        ),        
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0), // Adjust the padding as needed
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.account_circle,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality for the plus button
        },
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: Icon(
          Icons.add,
          size: 50, // Adjust size of the icon
          color: Color.fromARGB(255, 54, 106, 57),
        ), // Change background color if needed
      ),    
    );
  }
}