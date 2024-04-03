// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:firstly/main_page.dart';
import 'package:firstly/wallet_page_admin.dart';
import 'package:flutter/material.dart';
import 'package:firstly/Wallets/wallet.dart';
import 'package:firstly/Wallets/walletManager.dart';

class MemberListPage extends StatelessWidget {

  final Color customColor = Color(0xFF0A5440);

  List<List<Object>> listOfUsers = [
    ['User_1', 'Admin'],
    ['User_2', 'Admin'],
    ['User_3', 'Admin'],
    ['User_4', 'Member'],
    ['User_5', 'Member'],
    ['User_6', 'Member'],
    ['User_7', 'Member'],
    ['User_8', 'Member'],
    ['User_9', 'Member'],
    ['User_10', 'Member'],
    ['User_11', 'Member'],
    ['User_12', 'Member'],
    ['User_13', 'Member'],
    ['User_14', 'Member'],
    ['User_15', 'Member'],
    ['User_16', 'Member'],
    ['User_17', 'Member'],
    ['User_18', 'Member'],
    ['User_19', 'Member'],
    ['User_20', 'Member'],
  ];

  Wallet wallet;
  MemberListPage() : wallet = WalletManager.selectedWallet!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallets of Wallets',
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: customColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(left: 40.0 , right: 40.0 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
    
                          Text(
                            '${wallet.walletName}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: customColor),
                          ),
                          
                          Text(
                            '${wallet.walletDescription}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: customColor),
                          ),


                          Text(
                            'Payment: ₺${wallet.walletPaymentAmount}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: customColor),
                          ),
                        ],
                    ),

                    Text(
                        'ID: ${wallet.walletId}',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: customColor),
                    ),
                  ],
                ),
              ),

             SizedBox(height: 15.0),
              for (int user = 0; user < listOfUsers.length; user++)
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
                              showSlideWindow(context, listOfUsers[user][0] as String, listOfUsers[user][1] as String);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: listOfUsers[user][1] == 'Admin' ? Color.fromARGB(255, 162, 68, 229) : Color.fromARGB(255, 35, 147, 157),
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
                                    "${listOfUsers[user][0]}",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 6, 7, 6),
                                    ),
                                  ),
                                  Text(
                                    "${listOfUsers[user][1]}",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 6, 6, 6),
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
            icon: Icon(Icons.paid, size: 30.0), // Change the size value to your desired size
            label: 'Payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet, size: 30.0), // Change the size value to your desired size
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 30.0), // Change the size value to your desired size
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
              // Handle transactions navigation
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WalletPageAdmin()),
              );
              // Handle users navigation
              break;
            case 3:
              // Handle settings navigation
              break;
          }
        },
      ),
    );
  }
  void showSlideWindow(BuildContext context, String userName, String userRole) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 350,
          color: customColor, // Change the background color to blue
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  Text(
                    '${userName}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${userRole}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50), // Add spacing between buttons
                  SizedBox(
                    width: 250.0, // Adjust the width as needed
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(120.0, 50.0),
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        userRole == 'Admin' ? 'Dismis as Admin' : 'Make Wallet Admin',
                        style: TextStyle(
                          color: userRole == 'Admin' ? Colors.red : customColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30), // Add spacing between buttons
                  SizedBox(
                    width: 250.0, // Adjust the width as needed
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(120.0, 50.0),
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Remove User From Wallet',
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