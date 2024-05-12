import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstly/Transactions/transaction.dart';
import 'dart:math';

class TransactionManager {

  static Map<String, List<TransactionWallet>> transactions = {};

  static String generateRandomId() {
    Random random = Random();
    int randomNumber = random.nextInt(1000000);
    return 'TXN$randomNumber';
  }

  static Future<TransactionWallet> generateTransaction(String walletID, String type, double amount, String date, String userEmail) async{
    
    String transactionId = generateRandomId();
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userEmail).get();
    
    TransactionWallet transaction = TransactionWallet(
      transactionID: transactionId,
      walletID: walletID,
      type: type,
      amount: amount,
      date: date,
      userEmail: userEmail,
      name: userSnapshot['name'],
    );

    return transaction;
  }
  
  static void addTransaction(TransactionWallet transaction) {
    transactions[transaction.walletID]!.add(transaction);
  }

  static List<TransactionWallet> getTransactions(String walletID) {
    if(transactions[walletID] == null) {
      return transactions[walletID] = [];
    }
    return transactions[walletID]!;
  }

  static void setTransactions(List<TransactionWallet> transactionsList) {
    transactionsList.forEach((transaction) {
      if(transactions[transaction.walletID] == null) {
        transactions[transaction.walletID] = [];
      }
      transactions[transaction.walletID]!.add(transaction);
    });
  }
  
}