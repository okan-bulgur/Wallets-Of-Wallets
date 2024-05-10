import 'package:flutter/material.dart';
import 'package:firstly/deposite_page_admin.dart';
import 'package:firstly/withdraw_page_admin.dart';
import 'package:firstly/Wallets/wallet.dart';
import 'package:firstly/Wallets/walletManager.dart';
import 'package:firstly/main_page.dart';
import 'package:firstly/member_list_page.dart';
import 'package:firstly/wallet_page_admin.dart';
import 'package:firstly/wallet_setting.dart';

class TransactionPageAdmin extends StatelessWidget {
  final Color customColor = const Color(0xFF0A5440);

  @override
  Widget build(BuildContext context) {
    final Wallet? selectedWallet = WalletManager.selectedWallet;

    if (selectedWallet == null) {
      // Handle if no wallet is selected
      return Scaffold(
        body: Center(
          child: Text('No wallet selected!'),
        ),
      );
    }

    TextEditingController amountController = TextEditingController();

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 75.0),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedWallet.walletName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: customColor,
                          ),
                        ),
                        Text(
                          selectedWallet.walletDescription,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: customColor,
                          ),
                        ),
                        Text(
                          'Payment: ₺${selectedWallet.walletPaymentAmount}',
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
                      'ID: ${selectedWallet.walletId}',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: customColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        filled: true,
                        fillColor: const Color.fromARGB(100, 150, 150, 150),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60.0),
                    SizedBox(
                      width: 250.0,
                      child: ElevatedButton(
                        onPressed: () {
                          double? amount =
                              double.tryParse(amountController.text);
                          if (amount != null && amount > 0) {
                            // Navigate to deposit page with amount
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DepositPageAdmin(amount: amount),
                              ),
                            );
                          } else {
                            // Handle invalid amount
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please enter a valid amount.'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: customColor,
                          minimumSize: const Size(120.0, 40.0),
                        ),
                        child: const Text(
                          'Deposit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Add spacing between buttons
                    SizedBox(
                      width: 250.0,
                      child: ElevatedButton(
                        onPressed: () {
                          double? amount =
                              double.tryParse(amountController.text);
                          if (amount != null && amount > 0) {
                            // Navigate to withdraw page with amount
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    WithdrawPageAdmin(amount: amount),
                              ),
                            );
                          } else {
                            // Handle invalid amount
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please enter a valid amount.'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: customColor,
                          minimumSize: const Size(120.0, 40.0),
                        ),
                        child: const Text(
                          'Withdraw',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
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
        currentIndex: 1, // Indicates the current page
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
              // Current page, do nothing
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
