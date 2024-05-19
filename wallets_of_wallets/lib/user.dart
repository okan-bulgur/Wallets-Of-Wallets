class UserSession {
  String _name;
  String _surname;
  String _email;
  String _photoUrl;
  double _balance;
 
  UserSession({required String name, required String surname, required String email, required String photoUrl, required double balance})
      : _name = name,
        _surname = surname,
        _email = email,
        _photoUrl = photoUrl,
        _balance = balance;

  String get userName => _name;
  set userName(String newName) => _name = newName;

  String get userSurname => _surname;
  set userSurname(String newSurname) => _surname = newSurname;

  String get userEmail => _email;
  set userEmail(String newEmail) => _email = newEmail;

  String get userPhotoUrl => _photoUrl;
  set userPhotoUrl(String newPhotoUrl) => _photoUrl = newPhotoUrl;

  double get userBalance => _balance;
  set userBalance(double newBalance) => _balance = newBalance;
}