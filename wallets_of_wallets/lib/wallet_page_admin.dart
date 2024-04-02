// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firstly/qr_page.dart';
import 'package:flutter/material.dart';

class WalletPageAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wallets of Wallets',
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 54, 106, 57)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.qr_code,
              color: Color.fromARGB(255, 54, 106, 57), // Replace with your desired color
              size: 40, // Replace with your desired size
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QrPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Wallets of Wallets',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 54, 106, 57)),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.qr_code,
                      color: Color.fromARGB(255, 54, 106, 57), // Replace with your desired color
                      size: 40, // Replace with your desired size
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QrPage(),
                        ),
                      );
                    },
                  ), 
                ],
              ),
              SizedBox(height: 60.0),
              Text(
                  '₺1000,00',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 17, 17, 17)),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(left: 40.0 , right: 40.0 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
    
                          Text(
                            'Wallet Name',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 3, 3, 3)),
                          ),
                          
                          Text(
                            'Wallet Description',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 9, 9, 9)),
                          ),

                        ],
                    ),

                    Text(
                        'Wallet ID',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 10, 10, 10)),
                    ),
                    
                    
                   
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              
              Padding(
                padding: const EdgeInsets.only(left: 40.0 , right: 40.0 ),
                child: Row(
                  children: [
                    
                    Text(
                        'Account Movements',
                          style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 3, 3, 3)),
                    ),
                    SizedBox(width: 5.0),
                    Icon(
                        Icons.chevron_right,
                        size: 15.0,
                        color: Color.fromARGB(255, 54, 106, 57),
                    ),
                    
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 30.0,right: 30.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 142, 243, 235),
                        ),
                        
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0 , right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Member 2",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 6, 7, 6),
                                    ),
            
                                  ),
                                  Text(
                                    "Incomming",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 54, 106, 57),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "₺ 400,00",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(255, 6, 6, 6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 142, 243, 235),
                        ),
                        
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0 , right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Member 2",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 6, 7, 6),
                                    ),
            
                                  ),
                                  Text(
                                    "Incomming",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 54, 106, 57),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "₺ 400,00",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(255, 6, 6, 6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 142, 243, 235),
                        ),
                        
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0 , right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Member 2",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 6, 7, 6),
                                    ),
            
                                  ),
                                  Text(
                                    "Incomming",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 54, 106, 57),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "₺ 400,00",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(255, 6, 6, 6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 142, 243, 235),
                        ),
                        
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0 , right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Member 2",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 6, 7, 6),
                                    ),
            
                                  ),
                                  Text(
                                    "Incomming",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 54, 106, 57),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "₺ 400,00",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(255, 6, 6, 6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),










                  ],
                ),
              )

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Create Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Transactions',
          ),
        ],
        selectedIconTheme: IconThemeData(color: Color.fromARGB(255, 54, 106, 57)), // Set color for selected icon
        unselectedIconTheme: IconThemeData(color: Color.fromARGB(255, 54, 106, 57)), // Set color for unselected icon
        onTap: (index) {
          
        },
      ),
    );
  }
}