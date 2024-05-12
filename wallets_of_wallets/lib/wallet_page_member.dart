// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:firstly/Transactions/transaction.dart';
import 'package:firstly/Transactions/transactionManager.dart';
import 'package:firstly/main_page.dart';
import 'package:firstly/member_list_page_member.dart';
import 'package:firstly/qr_page_member.dart';
import 'package:firstly/transaction_page_member.dart';
import 'package:flutter/material.dart';
import 'package:firstly/Wallets/wallet.dart';
import 'package:firstly/Wallets/walletManager.dart';

class WalletPageMember extends StatelessWidget {

  final Color customColor = Color(0xFF0A5440);

  List<TransactionWallet> listOfTransactions = TransactionManager.getTransactions(WalletManager.selectedWallet!.walletId);

  Wallet wallet;

  WalletPageMember() : wallet = WalletManager.selectedWallet!;

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
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.qr_code,
              color: customColor, // Replace with your desired color
              size: 40, // Replace with your desired size
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QrPageMember(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 60.0),
              Text(
                  '₺${wallet.walletBalance}',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: customColor),
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
              
              Padding(
                padding: const EdgeInsets.only(left: 40.0 , right: 40.0 ),
                child: Row(
                  children: [
                    
                    Text(
                        'Account Movements',
                          style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: customColor),
                    ),
                    SizedBox(width: 5.0),
                    Icon(
                        Icons.chevron_right,
                        size: 15.0,
                        color: customColor,
                    ),
                    
                  ],
                ),
              ),

             SizedBox(height: 15.0),
              for (int movement = 0; movement < listOfTransactions.length; movement++)

                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 70.0,
                          decoration: BoxDecoration(
                            color: listOfTransactions[movement].type == 'Outcoming' 
                                  ? const Color.fromARGB(255, 206, 136, 131) 
                                  : const Color.fromARGB(255, 151, 222, 153),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${listOfTransactions[movement].name}",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color.fromARGB(255, 6, 7, 6),
                                        ),
                                      ),
                                      Text(
                                        "${listOfTransactions[movement].type}",
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "₺ ${listOfTransactions[movement].amount}",
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
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group, size: 30.0), // Change the size value to your desired size
            label: 'Members',
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
                MaterialPageRoute(builder: (context) => TransactionPageMember()), // Navigate to MainPage
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MemberListPageMember()), // Navigate to MainPage
              );
              break;
          }
        },
      ),
    );
  }
}