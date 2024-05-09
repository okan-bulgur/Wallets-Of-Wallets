import 'package:firstly/Cards/card.dart';
import 'package:flutter/material.dart';

class CardManager {
  static List<UserCard> cards = [];
  static UserCard? selectedCard;

  static void generateCard(String cvc, String cardName, String cardNumber, String expDate, String name) {
    UserCard card = UserCard(
      cvc: cvc,
      cardName: cardName,
      cardNumber: cardNumber,
      expDate: expDate,
      name: name,
    );
    CardManager.addCard(card);
  }

  static void setUsersCards(List<UserCard> cards) {
    if (CardManager.cards.isNotEmpty) {
      CardManager.cards.clear();
    }
    selectedCard = null;
    if (cards.isNotEmpty) {
      CardManager.cards = cards;
    }
  }
  
  static void addCard(UserCard card) {
    cards.add(card);
  }
}