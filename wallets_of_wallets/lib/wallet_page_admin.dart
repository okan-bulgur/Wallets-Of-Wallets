import 'package:firstly/Transactions/transaction.dart';
import 'package:firstly/Transactions/transactionManager.dart';
import 'package:firstly/main_page.dart';
import 'package:firstly/member_list_page.dart';
import 'package:firstly/qr_page.dart';
import 'package:firstly/transaction_page_admin.dart';
import 'package:firstly/wallet_setting.dart';
import 'package:flutter/material.dart';
import 'package:firstly/Wallets/wallet.dart';
import 'package:firstly/Wallets/walletManager.dart';

// ignore: must_be_immutable
class WalletPageAdmin extends StatelessWidget {
  final Color customColor = Color(0xFF0A5440);

  Wallet wallet;
  List<TransactionWallet> listOfTransactions = TransactionManager.getTransactions(WalletManager.selectedWallet!.walletId);
  
  WalletPageAdmin() : wallet = WalletManager.selectedWallet!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallets of Wallets',
          style: TextStyle(
              fontSize: 30.0, fontWeight: FontWeight.bold, color: customColor),
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
                  builder: (context) => QrPage(),
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
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
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
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
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
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30.0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.paid, size: 30.0),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group, size: 30.0),
            label: 'Members',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 30.0),
            label: 'Settings',
          ),
          // Add a new BottomNavigationBarItem for Transactions
        ],
        selectedItemColor: customColor,
        selectedFontSize: 14.5,
        showUnselectedLabels: true,
        unselectedItemColor: customColor,
        unselectedFontSize: 14.5,
        unselectedLabelStyle: TextStyle(color: customColor),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransactionPageAdmin(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemberListPage()), // Navigate to MainPage
              );
              // Handle members navigation
              break;
            case 3:
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletSetting()), // Navigate to MainPage
              );
              break;
          }
        },
      ),
    );
  }
}
