import 'package:flutter/material.dart';

class UserCard {
  String _cardID;
  String _cvc;
  String _cardName;
  String _cardNumber;
  String _expDate;
  String _name;
 
  UserCard({required String cvc, required String cardName, required String cardNumber, required String expDate, required String name, required String cardID})
      : _cvc = cvc,
        _cardName = cardName,
        _cardNumber = cardNumber,
        _expDate = expDate,
        _name = name,
        _cardID = cardID;

  String get cardCvc => _cvc;
  set cardCvc(String newCvc) => _cvc = newCvc;

  String get cardCardName => _cardName;
  set cardCardName(String newCardName) => _cardName = newCardName;

  String get cardNumber => _cardNumber;
  set cardNumber(String newCardNumber) => _cardNumber = newCardNumber;
  
  String get cardExpDate => _expDate;
  set cardExpDate(String newCardExpDate) => _expDate = newCardExpDate;

  String get cardName => _name;
  set cardName(String newName) => _name = newName;

  String get cardID => _cardID;
  set cardID(String newCardID) => _cardID = newCardID;
}