import 'package:firstly/Wallets/wallet.dart';
import 'package:flutter/material.dart';

class WalletManager {
  static List<Wallet> wallets = [];
  static Wallet? selectedWallet;

  static void generateWallet(Color selectedColor, String name, String description, String id, int balance, int paymentAmount) {
    Wallet wallet = Wallet(
      color: selectedColor,
      name: name,
      description: description,
      id: id,
      balance: balance,
      paymentAmount: paymentAmount,
    );
    WalletManager.addWallet(wallet);
  }

  static void setUsersWallets(List<Wallet> wallets) {
    if (WalletManager.wallets.isNotEmpty) {
      WalletManager.wallets.clear();
    }
    selectedWallet = null;
    if (wallets.isNotEmpty) {
      WalletManager.wallets = wallets;
    }
  }
  
  static void addWallet(Wallet wallet) {
    wallets.add(wallet);
  }
}