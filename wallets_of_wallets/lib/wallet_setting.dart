import 'dart:io';

import 'package:firstly/Wallets/wallet.dart';
import 'package:firstly/data_base_manager.dart';
import 'package:firstly/main_page.dart';
import 'package:firstly/wallet_page_admin.dart';
import 'package:flutter/material.dart';
import 'package:firstly/Wallets/walletManager.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class WalletSetting extends StatefulWidget {
  @override
  _WalletSetting createState() => _WalletSetting();
}

class _WalletSetting extends State<WalletSetting> {
  final Color customColor = Color(0xFF0A5440);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController paymentAmountController = TextEditingController();
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = WalletManager.selectedWallet!.walletColor;
  }

  void changeColor(Color color) {
    setState(() => selectedColor = color);
  }

  final Wallet wallet;
  _WalletSetting({Key? key}) 
    : wallet = WalletManager.selectedWallet!;

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
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0), // Make corners curvy
                              ),
                              title: Text('Select a color'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: selectedColor,
                                  onColorChanged: changeColor,
                                  showLabel: true,
                                  pickerAreaHeightPercent: 0.8,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'SET COLOR',
                                    style: TextStyle(
                                      color: customColor, // Same color as title
                                    ),
                                  ),
                                  onPressed: () {
                                    WalletsTableManager.updateWalletColor(context, wallet.walletId, selectedColor);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: selectedColor,
                          borderRadius: BorderRadius.circular(10.0), // Make corners curvy
                        ),
                      ),
                    ),
                    
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
                              controller: nameController,
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
                            WalletsTableManager.updateWalletName(context, wallet.walletId, nameController.text.trim());
                            setState(() {
                              wallet.walletName = nameController.text.trim();
                            });
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
                              controller: descriptionController,
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
                            WalletsTableManager.updateWalletDescription(context, wallet.walletId, descriptionController.text.trim());
                            setState(() {
                              wallet.walletDescription = descriptionController.text.trim();
                            });
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
                            controller: paymentAmountController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                            ],
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
                              WalletsTableManager.updateWalletPaymentAmount(context, wallet.walletId, double.parse(paymentAmountController.text.trim()));
                              setState(() {
                                wallet.walletPaymentAmount = double.parse(paymentAmountController.text.trim());
                              });
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

                    SizedBox(height: 10.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            WalletsTableManager.deleteWallet(context, wallet.walletId);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MainPage()),
                            );
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                          label: Text(
                            'Delete Wallet',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    )
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
