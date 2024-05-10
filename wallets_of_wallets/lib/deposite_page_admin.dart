import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstly/main_page.dart';
import 'package:firstly/member_list_page.dart';
import 'package:firstly/wallet_page_admin.dart';
import 'package:firstly/wallet_setting.dart';
import 'package:flutter/material.dart';
import 'package:firstly/Wallets/wallet.dart';
import 'package:firstly/Wallets/walletManager.dart';

class DepositPageAdmin extends StatelessWidget {
  final Color customColor = const Color(0xFF0A5440);
  final Wallet wallet;
  final double amount;

  DepositPageAdmin({Key? key, required this.amount})
      : wallet = WalletManager.selectedWallet!,
        super(key: key);

  Future<void> depositToWallet(BuildContext context, double amount) async {
    try {
      // Update Firestore document
      await FirebaseFirestore.instance
          .collection('wallets')
          .doc(wallet.walletId)
          .update({
        'balance': FieldValue.increment(amount),
        'paymentAmount': FieldValue.increment(amount), // Update payment amount
      });

      // Fetch updated wallet data from Firestore
      DocumentSnapshot<Object?> walletSnapshot = await FirebaseFirestore
          .instance
          .collection('wallets')
          .doc(wallet.walletId)
          .get();

      // Update local wallet object with the latest data
      final Map<String, dynamic>? walletData =
          walletSnapshot.data() as Map<String, dynamic>?;
      if (walletData != null) {
        wallet.walletBalance = walletData['balance'] as double;
        wallet.walletPaymentAmount = walletData['paymentAmount'] as double;
      }

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deposit successful')),
      );
    } catch (e) {
      // Handle deposit error
      print("Error depositing: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to deposit. Please try again.')),
      );
    }
  }

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
              const SizedBox(height: 75.0),
              Text(
                '₺${wallet.walletBalance}',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: customColor,
                ),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          wallet.walletName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: customColor,
                          ),
                        ),
                        Text(
                          wallet.walletDescription,
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
              const SizedBox(height: 125.0),
              ElevatedButton(
                onPressed: () {
                  depositToWallet(
                      context, amount); // Pass amount to depositToWallet
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor,
                  minimumSize: const Size(275.0, 45.0),
                ),
                child: const Text(
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
                MaterialPageRoute(
                  builder: (context) => WalletSetting(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
