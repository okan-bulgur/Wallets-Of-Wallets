
// ignore_for_file: use_super_parameters, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class WalletsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample wallet data
    List<Wallet> wallets = [
      Wallet(name: 'Wallet 1', balance: 100.0),
      Wallet(name: 'Wallet 2', balance: 200.0),
      Wallet(name: 'Wallet 3', balance: 300.0),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Wallets'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: wallets.length,
        itemBuilder: (context, index) {
          return WalletCard(wallet: wallets[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add logic to navigate to the page for adding a new wallet
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Wallet {
  final String name;
  final double balance;

  Wallet({required this.name, required this.balance});
}

class WalletCard extends StatelessWidget {
  final Wallet wallet;

  const WalletCard({Key? key, required this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.account_balance_wallet),
        title: Text(wallet.name),
        subtitle: Text('Balance: \$${wallet.balance.toStringAsFixed(2)}'),
        onTap: () {
          // Add logic to navigate to the detailed view of the selected wallet
        },
      ),
    );
  }
}