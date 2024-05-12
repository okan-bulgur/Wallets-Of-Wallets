class TransactionWallet {
  String _transactionID;
  String _walletID;
  String _type;
  double _amount;
  String _date;
  String _userEmail;
  String _name;
 
  TransactionWallet({required String transactionID, required String walletID, required String type, required double amount, required String date, required String userEmail, required String name})
      : _transactionID = transactionID,
        _walletID = walletID,
        _type = type,
        _amount = amount,
        _date = date,
        _userEmail = userEmail,
        _name = name;

  String get transactionID => _transactionID;
  set transactionID(String newTransactionID) => _transactionID = newTransactionID;

  String get walletID => _walletID;
  set walletID(String newWalletID) => _walletID = newWalletID;

  String get type => _type;
  set type(String newType) => _type = newType;

  double get amount => _amount;
  set amount(double newAmount) => _amount = newAmount;

  String get date => _date;
  set date(String newDate) => _date = newDate;

  String get userEmail => _userEmail;
  set userEmail(String newUserEmail) => _userEmail = newUserEmail;

  String get name => _name;
  set name(String newName) => _name = newName;
}