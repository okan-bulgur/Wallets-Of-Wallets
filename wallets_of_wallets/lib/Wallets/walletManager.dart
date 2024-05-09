import 'package:firstly/Wallets/wallet.dart';
import 'package:flutter/material.dart';

class WalletManager {
  static List<Wallet> wallets = [];
  static Wallet? selectedWallet;

  static void generateWallet(Color selectedColor, String name, String description, String id, double balance, double paymentAmount) {
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

  static void updateWalletName(String name) {
    if (selectedWallet != null) {
      selectedWallet?.walletName = name;
    }
  }

  static void updateWalletDescription(String description) {
    if (selectedWallet != null) {
      selectedWallet?.walletDescription = description;
    }
  }

  static void updateWalletPaymentAmount(double amount) {
    if (selectedWallet != null) {
      selectedWallet?.walletPaymentAmount = amount;
    }
  }

  static void updateWalletColor(Color color) {
    if (selectedWallet != null) {
      selectedWallet?.walletColor = color;
    }
  }
  
  static void addWallet(Wallet wallet) {
    wallets.add(wallet);
  }
}