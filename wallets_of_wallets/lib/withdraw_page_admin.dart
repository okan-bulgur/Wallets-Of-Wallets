import 'package:firstly/Wallets/wallet.dart';
import 'package:firstly/card_selection_page.dart';
import 'package:firstly/data_base_manager.dart';
import 'package:firstly/member_list_page.dart';
import 'package:firstly/wallet_page_admin.dart';
import 'package:firstly/wallet_setting.dart';
import 'package:flutter/material.dart';
import 'package:firstly/main_page.dart';

class WithdrawPageAdmin extends StatelessWidget {
  final Color customColor = const Color(0xFF0A5440);

  final Wallet wallet;
  final double amount;

  WithdrawPageAdmin({required this.amount}) : 
    wallet = WalletsTableManager.selectedWallet!;

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 75.0),
              Text(
                '₺$amount',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: customColor,
                ),
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
              SizedBox(height: 125.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardSelectionPage(
                        onCardSelected: (selectedCard) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Withdraw To Card'),
                                content: Text('Are you sure you want to withdraw to ${selectedCard.cardCardName}?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await TransactionTableManager.withdrawToCard(context, wallet.walletId, amount);
                                      await Future.delayed(Duration(milliseconds: 500));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => WalletPageAdmin()),
                                      );
                                    },
                                    child: Text('Withdraw'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor,
                  minimumSize: Size(275.0, 45.0),
                ),
                child: Text(
                  'To Bank Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Withdraw To Balance'),
                        content: Text('Are you sure you want to withdraw to your balance?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async{
                              await TransactionTableManager.withdrawToUserBalance(context, wallet.walletId, amount);
                              await Future.delayed(Duration(milliseconds: 500));
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => WalletPageAdmin()),
                              );
                            },
                            child: Text('Withdraw'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor,
                  minimumSize: Size(275.0, 45.0),
                ),
                child: Text(
                  'To Main Wallet',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
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
            icon: Icon(Icons.wallet, size: 30.0),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group, size: 30.0),
            label: 'Members',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 30.0),
            label: 'Settings',
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
                MaterialPageRoute(
                  builder: (context) => WalletPageAdmin(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MemberListPage()),
              );
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