import 'package:flutter/material.dart';

class Wallet {
  Color _color;
  String _name;
  String _description;
  String _id;
  double _balance;
  double _paymentAmount;
 
  Wallet({required Color color, required String name, required String description, required String id, required double balance, required double paymentAmount})
      : _color = color,
        _name = name,
        _description = description,
        _id = id,
        _balance = balance,
        _paymentAmount = paymentAmount;

  Color get walletColor => _color;
  set walletColor(Color newColor) => _color = newColor;

  String get walletName => _name;
  set walletName(String newName) => _name = newName;

  String get walletDescription => _description;
  set walletDescription(String newDescription) => _description = newDescription;
  
  String get walletId => _id;
  set walletId(String newId) => _id = newId;

  double get walletBalance => _balance;
  set walletBalance(double newBalance) => _balance = newBalance;

  double get walletPaymentAmount => _paymentAmount;
  set walletPaymentAmount(double newBalance) => _paymentAmount = newBalance;

}