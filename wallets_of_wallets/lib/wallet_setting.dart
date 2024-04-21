// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:firstly/Wallets/wallet.dart';
import 'package:firstly/main_page.dart';
import 'package:firstly/wallet_page_admin.dart';
import 'package:flutter/material.dart';
import 'package:firstly/Wallets/walletManager.dart';

class WalletSetting extends StatelessWidget {
  final Color customColor = Color(0xFF0A5440);

  final Wallet wallet;
  WalletSetting({Key? key}) 
    : wallet = WalletManager.selectedWallet!,
      super(key: key);

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
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 80.0),
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
                            color: customColor,
                          ),
                        ),
                        Text(
                          '${wallet.walletDescription}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: customColor,
                          ),
                        ),
                        Text(
                          'Payment: ₺${wallet.walletPaymentAmount}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: customColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'ID: ${wallet.walletId}',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: customColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.0),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Change Wallet\'s Name',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: customColor,
                        ),
                      ),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Expanded(
                        child: TextField(
                              maxLength: 10,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                filled: true,
                                fillColor: Color.fromARGB(100, 150, 150, 150),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                              ),
                              onChanged: (value) {
                              },
                            ),
                      ),

                      SizedBox(width: 10.0),
                      
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your logic here
                          },
                          child: Text(
                            'Set',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: customColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),

                    ],),

                    SizedBox(height: 10.0,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Change Wallet\'s Description',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: customColor,
                        ),
                      ),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Expanded(
                        child: TextField(
                              maxLength: 20,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                filled: true,
                                fillColor: Color.fromARGB(100, 150, 150, 150),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                              ),
                              onChanged: (value) {
                              },
                            ),
                      ),

                      SizedBox(width: 10.0),
                      
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your logic here
                          },
                          child: Text(
                            'Set',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: customColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),

                    ],),

                    SizedBox(height: 10.0,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Determine Amount of the Payment',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: customColor,
                        ),
                      ),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                                maxLength: 10,
                                decoration: InputDecoration(
                                  labelText: 'Amount',
                                  filled: true,
                                  fillColor: Color.fromARGB(100, 150, 150, 150),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                ),
                                onChanged: (value) {
                                },
                              ),
                        ),

                        SizedBox(width: 10.0),
                        
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Add your logic here
                            },
                            child: Text(
                              'Set',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: customColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
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
            icon: Icon(Icons.wallet, size: 30.0),
            label: 'Wallet',
          ),
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
                MaterialPageRoute(builder: (context) => WalletPageAdmin()),
              );
              break;
          }
        },
      ),
    );
  }
}
