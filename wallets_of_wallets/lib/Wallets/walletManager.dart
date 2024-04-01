import 'package:firstly/Wallets/wallet.dart';
import 'package:flutter/material.dart';

import 'dart:math';

String generateRandomString(int length) {
  const _randomChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  const _charsLength = _randomChars.length;
  final _rnd = Random();

  final codeUnits = List.generate(
    length,
    (index) => _randomChars[_rnd.nextInt(_charsLength)].codeUnitAt(0),
  );

  return String.fromCharCodes(codeUnits);
}

class WalletManager {
  static List<Wallet> wallets = [];

  static generateWallet(Color selectedColor, String name, String description) {
    Wallet wallet = Wallet(
      color: selectedColor,
      name: name,
      description: description,
      id: generateRandomString(6),
    );
    WalletManager.addWallet(wallet);
  }
  
  static void addWallet(Wallet wallet) {
    wallets.add(wallet);
  }
}