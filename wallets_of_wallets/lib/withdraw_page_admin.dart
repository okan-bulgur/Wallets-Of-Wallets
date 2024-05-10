import 'package:firstly/main_page.dart';
import 'package:firstly/member_list_page.dart';
import 'package:firstly/wallet_page_admin.dart';
import 'package:firstly/wallet_setting.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstly/Wallets/wallet.dart';
import 'package:firstly/Wallets/walletManager.dart';

class WithdrawPageAdmin extends StatelessWidget {
  final Color customColor = const Color(0xFF0A5440);
  final Wallet wallet;
  final double amount;

  WithdrawPageAdmin({Key? key, required this.amount})
      : wallet = WalletManager.selectedWallet!,
        super(key: key);

  // Method to handle the withdrawal action
  Future<void> withdrawFromWallet(BuildContext context, double amount) async {
    try {
      // Check if the withdrawal amount is valid
      if (amount > wallet.walletBalance) {
        // Show error message if the withdrawal amount exceeds the balance
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Insufficient balance')),
        );
        return;
      }

      // Deduct the amount from the wallet balance
      double updatedBalance = wallet.walletBalance - amount;
      double updatedPaymentAmount = wallet.walletPaymentAmount - amount;

      // Update the wallet balance in Firestore
      await FirebaseFirestore.instance
          .collection('wallets')
          .doc(wallet.walletId)
          .update({
        'balance': updatedBalance,
        'paymentAmount': updatedPaymentAmount,
      });

      // Update the wallet object with the new balance
      wallet.walletBalance = updatedBalance;
      wallet.walletPaymentAmount = updatedPaymentAmount;

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Withdrawal successful')),
      );
    } catch (e) {
      // Handle withdrawal error
      print("Error withdrawing: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to withdraw. Please try again.')),
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
              const SizedBox(height: 15.0),
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
                  withdrawFromWallet(context, amount);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor,
                  minimumSize: const Size(275.0, 45.0),
                ),
                child: const Text(
                  'From Main Wallet',
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
                MaterialPageRoute(builder: (context) => WalletPageAdmin()),
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
                MaterialPageRoute(builder: (context) => WalletSetting()),
              );
              break;
          }
        },
      ),
    );
  }
}
