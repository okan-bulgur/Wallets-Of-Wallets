import 'package:flutter/material.dart';

class Wallet {
  Color _color;
  String _name;
  String _description;
  String _id;

  int _balance = 0;
  int _paymentAmount = 0;
 
  Wallet({required Color color, required String name, required String description, required String id})
      : _color = color,
        _name = name,
        _description = description,
        _id = id;

  Color get walletColor => _color;
  set walletColor(Color newColor) => _color = newColor;

  String get walletName => _name;
  set walletName(String newName) => _name = newName;

  String get walletDescription => _description;
  set walletDescription(String newDescription) => _description = newDescription;
  
  String get walletId => _id;
  set walletId(String newId) => _id = newId;

  int get walletBalance => _balance;
  set balance(int newBalance) => _balance = newBalance;

  int get walletPaymentAmount => _paymentAmount;
  set paymentAmount(int newBalance) => _paymentAmount = newBalance;
}