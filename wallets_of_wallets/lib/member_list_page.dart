// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:firstly/main_page.dart';
import 'package:firstly/wallet_page_admin.dart';
import 'package:flutter/material.dart';
import 'package:firstly/Wallets/wallet.dart';
import 'package:firstly/Wallets/walletManager.dart';

class MemberListPage extends StatelessWidget {

  final Color customColor = Color(0xFF0A5440);

  List<List<Object>> listOfMembers = [
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
              for (int member = 0; member < listOfMembers.length; member++)
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
                              showSlideWindow(context, listOfMembers[member][0].toString());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: listOfMembers[member][1] == 'Admin' ? Color.fromARGB(255, 162, 68, 229) : Color.fromARGB(255, 35, 147, 157),
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
                                    "${listOfMembers[member][0]}",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 6, 7, 6),
                                    ),
                                  ),
                                  Text(
                                    "${listOfMembers[member][1]}",
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
              // Handle members navigation
              break;
            case 3:
              // Handle settings navigation
              break;
          }
        },
      ),
    );
  }
  void showSlideWindow(BuildContext context, String memberName) {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Center(
            child: Text(
              'This is the specific slide window for $memberName',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}