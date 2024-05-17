import 'package:firstly/Transactions/transaction.dart';
import 'package:firstly/Wallets/wallet.dart';
import 'dart:io';
import 'package:firstly/Cards/card.dart';
import 'package:firstly/Cards/cardManager.dart';
import 'package:flutter/material.dart';
import 'package:firstly/login_page.dart';
import 'main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

FirebaseApp app = Firebase.app();
String? userEmail;
String? userPhoto;


class AuthenticationManager {

  static login(BuildContext context, email, String password) async {
    try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        userEmail = FirebaseAuth.instance.currentUser!.email;
        
        List<UserCard> cards = await CardsTableManager.getUserCards(email);
        CardManager.setUsersCards(cards);

        UsersTableManager.setUserPhoto(email);
        
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );

        userEmail = FirebaseAuth.instance.currentUser!.email;

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successful',textAlign: TextAlign.center,)));

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password or email is incorrect !',textAlign: TextAlign.center,)));
        print("Login error: $e");
      }
  }

  static signup(BuildContext context,String name, String surname, String email, String password) async {
    try {
      // Create a new user with the provided email and password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UsersTableManager.addUser(name, surname, email);
      // If signup successful, navigate to the desired page (e.g., main page)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup successful',textAlign: TextAlign.center,)));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), // Replace MainPage with your desired destination
      );
    } catch (e) {
      // Handle signup errors (e.g., display error message)
      print("Signup error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Signup failed. Please try again."),
        ),
      );
    }
  }

  static logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      userEmail = null;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print("Logout error: $e");
    }
  }

}

class UsersTableManager {

  static Future<void> addUser(String name, String surname, String email) async {
    try {
      print("Adding user: $name, $surname, $email");
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'name': name,
        'surname': surname,
        'email': email,
        'balance': 0,
        'list_of_wallets': Map<String, bool>(),
        'list_of_cards'  : Map<String, bool>(),
        'photo': '',
      });
    } catch (e) {
      print("Error adding user: $e");
    }
  }

  static Future<void> addWalletToUser(String walletID) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userEmail).update({
        'list_of_wallets': FieldValue.arrayUnion([walletID])
      });

    } catch (e) {
      print("Error adding wallet to user: $e");
    }  
  }

  static Future<void> updateUserName(BuildContext context, String userEmail, String firstName) async {
    try {

      if (firstName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid name',textAlign: TextAlign.center,)));
        return; // Stop further execution
      }
      // Update user data in Firestore using the user's email
      await FirebaseFirestore.instance.collection('users').doc(userEmail).update({
        'name': firstName,
      });

      // Show success message or navigate to another page
      // Example:
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Name updated successfully ',textAlign: TextAlign.center,)));
      // Navigator.pop(context as BuildContext); // Pop this screen and go back to the previous screen

    } catch (e) {
      print("Error updating user: $e");
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating user')));
    }
  }

  static Future<void> updateUserSurname(BuildContext context, String userEmail, String surname) async {
    try {

      if (surname.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid  surname',textAlign: TextAlign.center,)));
        return; // Stop further execution
      }
      // Update user data in Firestore using the user's email
      await FirebaseFirestore.instance.collection('users').doc(userEmail).update({
        'surname': surname,
      });

      // Show success message or navigate to another page
      // Example:
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Surname updated successfully',textAlign: TextAlign.center,)));
      // Navigator.pop(context as BuildContext); // Pop this screen and go back to the previous screen

    } catch (e) {
      print("Error updating user: $e");
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating user',textAlign: TextAlign.center,)));
    }
  }

  static Future<bool> updateUserBalance(BuildContext context, String userEmail, double amount, bool isAdding) async {

    // Yavuz: I added this function to update the balance of the user. It can be used to add or subtract balance from the user.
    // isAdding is a boolean variable that determines whether the balance will be added or subtracted.

    try {
      // Update user data in Firestore using the user's email
      if (isAdding) {
        await FirebaseFirestore.instance.collection('users').doc(userEmail).update({
          'balance': FieldValue.increment(amount),
        });
      } 
      else {
        //Check if there is enough balance to subtract
        DocumentSnapshot user = await FirebaseFirestore.instance.collection('users').doc(userEmail).get();
        if (user['balance'] < amount){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Not enough balance to subtract',textAlign: TextAlign.center,)));
          return false;
        }
        await FirebaseFirestore.instance.collection('users').doc(userEmail).update({
          'balance': FieldValue.increment(-amount),
        });
      }

      // Show success message or navigate to another page
      // Example:
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Balance updated successfully',textAlign: TextAlign.center,)));
      return true;
      // Navigator.pop(context as BuildContext); // Pop this screen and go back to the previous screen

    } catch (e) {
      print("Error updating user: $e");
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating user',textAlign: TextAlign.center,)));
    }
    return false;
  }

  static Future<void> deleteWalletFromUser(String walletID, String email) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(email).update({
        'list_of_wallets': FieldValue.arrayRemove([walletID])
      });
    } catch (e) {
      print("Error deleting wallet from user: $e");
    }
  }

  static Future<void> updateUserPhoto(BuildContext context, XFile file) async {
    try {
      
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

      //Get a reference to storage root
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');

      //Create a reference for the image to be stored
      Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

      //Handle errors/success
      try {
        //Store the file
        await referenceImageToUpload.putFile(File(file.path));
        //Delete the old photo
        if (userPhoto!.isNotEmpty) {
          await FirebaseStorage.instance.refFromURL(userPhoto!).delete();
        }
        //Success: get the download URL
        String imageUrl = await referenceImageToUpload.getDownloadURL();
        // Update user data in Firestore using the user's email
        await FirebaseFirestore.instance.collection('users').doc(userEmail).update({
          'photo': imageUrl,
        });

        await setUserPhoto(userEmail!);

        // Show success message or navigate to another page
        // Example:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Photo updated successfully',textAlign: TextAlign.center,)));
        // Navigator.pop(context as BuildContext); // Pop this screen and go back to the previous screen

      } catch (error) {
        //Some error occurred
        print("Error updating user photo: $error");
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating user photo',textAlign: TextAlign.center,)));
      }
    } catch (e) {
      print("Error updating user photo: $e");
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating user photo',textAlign: TextAlign.center,)));
    }
  }

  static Future<void> setUserPhoto(String email) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(email).get().then((value) {
        userPhoto = value.data()!['photo'];
      });
    } catch (e) {
      print("Error getting user photo: $e");
    }
  }
}

class WalletsTableManager{
  static Wallet? selectedWallet;
  
  static Future<void> addWallet(String walletID, String walletName, String walletDescription, Color walletColor, String email) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).set({
        'name': walletName,
        'id': walletID,
        'owner': email,
        'description': walletDescription,
        'balance': 0,
        'payment_amount': 0,
        'color': walletColor.value.toString(),
        'list_of_admins': [email],
        'list_of_members': [],
      });
      await FirebaseFirestore.instance.collection('users').doc(email).update({
        'list_of_wallets': FieldValue.arrayUnion([walletID])
      });

    } catch (e) {
      print("Error adding wallet: $e");
    }
  }

  static Future<void> addMemberToWallet(String walletID) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).update({
        'list_of_members': FieldValue.arrayUnion([userEmail])
      });
    } catch (e) {
      print("Error adding member to wallet: $e");
    }
  }

  static Future<bool> joinWallet(BuildContext context, String walletID) async {
    try {
      if(walletID.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid ID',textAlign: TextAlign.center)));
        return false;
      } 
      // Check if the text field is empty
      bool isThereWallet = await WalletsTableManager.isThereWallet(context, walletID);
      if (isThereWallet) {

        bool isUserAdmin = await WalletsTableManager.isUserAdminOfWallet(walletID);
        bool isUserMember = await WalletsTableManager.isUserMemberOfWallet(walletID);

        if (isUserAdmin || isUserMember) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You are already in the wallet ',textAlign: TextAlign.center)));
          return false;
        }
        WalletsTableManager.addMemberToWallet(walletID);
        UsersTableManager.addWalletToUser(walletID);
      }
    } catch (e) {
      print("Error joining wallet: $e");
      return false;
    }
    return true;
  }

  static Future<void> deleteWallet(BuildContext context, String walletID) async {
    try {

      await FirebaseFirestore.instance.collection('wallets').doc(walletID).get().then((value) async {
        List<String> admins = List<String>.from(value.data()!['list_of_admins']);
        List<String> members = List<String>.from(value.data()!['list_of_members']);

        for (var admin in admins) {
          await FirebaseFirestore.instance.collection('users').doc(admin).update({
            'list_of_wallets': FieldValue.arrayRemove([walletID])
          });
        }
        
        for (var member in members) {
          await FirebaseFirestore.instance.collection('users').doc(member).update({
            'list_of_wallets': FieldValue.arrayRemove([walletID])
          });
        }
      });

      await FirebaseFirestore.instance.collection('wallets').doc(walletID).delete();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wallet successfully deleted',textAlign: TextAlign.center,)));
    } catch (e) {
      print("Error deleting wallet: $e");
    }
  }

  static Future<void> updateWalletName(BuildContext context, String walletID, String name) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).update({
        'name': name,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Name of wallet updated successfully',textAlign: TextAlign.center)));
    } catch (e) {
      print("Error updating wallet balance: $e");
    }
  }

  static Future<void> updateWalletDescription(BuildContext context, String walletID, String description) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).update({
        'description': description,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Description of wallet updated successfully',textAlign: TextAlign.center)));
    } catch (e) {
      print("Error updating wallet balance: $e");
    }
  }

  static Future<bool> updateWalletBalance(BuildContext context, String walletID, double amount, bool isAdding) async {
    try {

      if(isAdding){
        await FirebaseFirestore.instance.collection('wallets').doc(walletID).update({
          'balance': FieldValue.increment(amount),
        });
        return true;
      }
      else{
        DocumentSnapshot wallet = await FirebaseFirestore.instance.collection('wallets').doc(walletID).get();
        if (wallet['balance'] < amount){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Not enough balance to subtract',textAlign: TextAlign.center)));
          return false;
        }
        await FirebaseFirestore.instance.collection('wallets').doc(walletID).update({
          'balance': FieldValue.increment(-amount),
        });
        return true;
      }

    } catch (e) {
      print("Error updating wallet balance: $e");
    }
    return false;
  }

  static Future<void> updateWalletPaymentAmount(BuildContext context, String walletID, double payment_amount) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).update({
        'payment_amount': payment_amount,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Payment amount of wallet updated successfully',textAlign: TextAlign.center)));
    } catch (e) {
      print("Error updating wallet balance: $e");
    }
  }

  static Future<void> updateWalletColor(BuildContext context, String walletID, Color color) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).update({
        'color': color.value.toString(),
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Color of wallet updated successfully',textAlign: TextAlign.center)));
    } catch (e) {
      print("Error updating wallet balance: $e");
    }
  }

  static Future<void> getWallet(String walletID) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).get();
    } catch (e) {
      print("Error getting wallet: $e");
    }
  }

  static Future<bool> isThereWallet(BuildContext context, String id) async {
    if (id.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Length of ID must be 6',textAlign: TextAlign.center,)));
      return false;
    }
    
    try {
      var querySnapshot = await FirebaseFirestore.instance.collection('wallets').get();
      for (var wallet in querySnapshot.docs) {
          if (wallet.data()['id'] == id) {
            return true;
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wallet not found !',textAlign: TextAlign.center,)));
      return false;
    }
    catch (e) {
      print("Error checking wallet: $e");
    }
    return false;
  }

  static Future<bool> isUserAdminOfWallet(String walletID) async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection('wallets').doc(walletID).get();
      if (snapshot.data()!['list_of_admins'].contains(userEmail)) {
        return true;
      } 
      else {
        return false;
      }
    } catch (e) {
      print("Error checking if user is admin: $e");
    }
    return false;
  }

  static Future<bool> isUserMemberOfWallet(String walletID) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).get().then((value) {
        print(value.data()!['list_of_members']);
        if (value.data()!['list_of_members'].contains(userEmail)) {
          print("User is member");
          return true;
        }
      });
    } catch (e) {
      print("Error checking if user is admin: $e");
    }
    return false;
  }

  static Future<void> dismissAsAdmin(BuildContext context, String walletID, String currentUser) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).update({
        'list_of_members': FieldValue.arrayUnion([currentUser]),
        'list_of_admins': FieldValue.arrayRemove([currentUser])
      });
    } catch (e) {
      print("Error dismissing as admin: $e");
    }
  }

  static Future<void> makeWalletAdmin(BuildContext context, String walletID, String currentUser) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).update({
        'list_of_admins': FieldValue.arrayUnion([currentUser]),
        'list_of_members': FieldValue.arrayRemove([currentUser])
      });
    } catch (e) {
      print("Error making wallet admin: $e");
    }
  }

  static Future<void> removeUserFromWallet(String walletID, String email) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).update({
        'list_of_admins': FieldValue.arrayRemove([email]),
        'list_of_members': FieldValue.arrayRemove([email])

      });
      await UsersTableManager.deleteWalletFromUser(walletID, email);
      
    } catch (e) {
      print("Error removing user from wallet: $e");
    }
  }

  static Future<List<Wallet>> getWalletsOfUser(String email) async{
    
    List<Wallet> wallets = [];
    try {
      FirebaseFirestore.instance.collection('users').doc(email).get().then((value) async {
        List<String> walletIDs = List<String>.from(value.data()!['list_of_wallets']);
        for (var walletID in walletIDs) {
          await FirebaseFirestore.instance.collection('wallets').doc(walletID).get().then((value) {
            wallets.add(Wallet(
              color: Color(int.parse(value.data()!['color'])),
              name: value.data()!['name'],
              description: value.data()!['description'],
              id: value.data()!['id'],
              balance: value.data()!['balance'].toDouble(),
              paymentAmount: value.data()!['payment_amount'].toDouble(),
            ));
          });
        }
      });
    } catch (e) {
      print("Error getting wallets: $e");
    }
    return wallets;
  
  }

  static Stream<List<Wallet>> getWalletsOfUserStream() {
    var email = FirebaseAuth.instance.currentUser!.email;
    return FirebaseFirestore.instance.collection('users').doc(email).snapshots().asyncMap((snapshot) async {
      List<String> walletIDs = List<String>.from(snapshot.data()!['list_of_wallets']);
      List<Wallet> wallets = [];
      for (var walletID in walletIDs) {
        var walletSnapshot = await FirebaseFirestore.instance.collection('wallets').doc(walletID).get();
        wallets.add(Wallet(
          color: Color(int.parse(walletSnapshot.data()!['color'])),
          name: walletSnapshot.data()!['name'],
          description: walletSnapshot.data()!['description'],
          id: walletSnapshot.data()!['id'],
          balance: walletSnapshot.data()!['balance'].toDouble(),
          paymentAmount: walletSnapshot.data()!['payment_amount'].toDouble(),
        ));
      }
      return wallets;
    });
  } 

  static Future<void> disjoinWallet(BuildContext context, String walletID) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).get().then((value) async {
        List<String> admins = List<String>.from(value.data()!['list_of_admins']);
        List<String> members = List<String>.from(value.data()!['list_of_members']);

        if (admins.contains(userEmail)) {
          if (admins.length == 1) {
            await deleteWallet(context, walletID);
          } 
          else {
            await FirebaseFirestore.instance.collection('wallets').doc(walletID).update({
              'list_of_admins': FieldValue.arrayRemove([userEmail])
            });
            await FirebaseFirestore.instance.collection('users').doc(userEmail).update({
              'list_of_wallets': FieldValue.arrayRemove([walletID])
            });
          }
        } 
        else if (members.contains(userEmail)) {
          await FirebaseFirestore.instance.collection('wallets').doc(walletID).update({
            'list_of_members': FieldValue.arrayRemove([userEmail])
          });
          await FirebaseFirestore.instance.collection('users').doc(userEmail).update({
            'list_of_wallets': FieldValue.arrayRemove([walletID])
          });
        }
      });
    } catch (e) {
      print("Error disjoining wallet: $e");
    }
  }
}


class CardsTableManager{

  static Future<void> addCard(String CVC, String cardName, String cardNumber, String expDate, String name,String email) async {
    try {
      // Create a new document in the 'cards' collection and get the reference
      DocumentReference cardRef = FirebaseFirestore.instance.collection('cards').doc();

      // Use the reference to set the data
      await cardRef.set({
        'cardID': cardRef.id, // Automatically generated ID
        'CVC': CVC,
        'cardName': cardName,
        'cardNumber': cardNumber,
        'expDate': expDate,
        'name': name
      });

      // Get the automatically generated ID from the document reference
      String cardID = cardRef.id;

      // Update the user's list of cards
      await FirebaseFirestore.instance.collection('users').doc(email).update({
        'list_of_cards': FieldValue.arrayUnion([cardID])
      });

      // Optionally generate a card using the data
      CardManager.generateCard(CVC, cardName, cardNumber, expDate, name,cardID);
    } catch (e) {
      print("Error adding card: $e");
    }
  }

  static Future<void> deleteCard(String cardID) async {
    try {
      await FirebaseFirestore.instance.collection('cards').doc(cardID).delete();

      // Update the user's list of cards
      await FirebaseFirestore.instance.collection('users').doc(userEmail).update({
        'list_of_cards': FieldValue.arrayRemove([cardID])
      });

      updateCardList();
    }
    catch (e) {
      print("Error deleting card: $e");
    }
    
  }

  static Future<List<UserCard>> getUserCards(String email) async {
    List<UserCard> cards = [];
    try {
      await FirebaseFirestore.instance.collection('users').doc(email).get().then((value) async {
        List<String> cardIDs = List<String>.from(value.data()!['list_of_cards']);
        for (var cardID in cardIDs) {
          await FirebaseFirestore.instance.collection('cards').doc(cardID).get().then((value) {
            cards.add(UserCard(
              cardID: value.data()!['cardID'],
              cvc: value.data()!['CVC'],
              cardName: value.data()!['cardName'],
              cardNumber: value.data()!['cardNumber'],
              expDate: value.data()!['expDate'],
              name: value.data()!['name'],
            ));
          });
        }
      });
    } catch (e) {
      print("Error getting cards: $e");
    }
    return cards;
  }

  static Future<void> updateCardList() async {
    CardManager.cards = await getUserCards(userEmail!);
  }

}


class TransactionTableManager{

  static Future<void> addTransaction(BuildContext context, String walletID, String type, double amount, String userEmail) async{
    try {

      DocumentReference transactionRef = FirebaseFirestore.instance.collection('transactions').doc();
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userEmail).get();
      String date = DateTime.now().toString();

      await transactionRef.set({
        'transactionID': transactionRef.id,
        'walletID': walletID,
        'type': type,
        'amount': amount,
        'date': date,
        'userEmail': userEmail,
        'name': userSnapshot['name'],
      });

    } catch (e) {
      print("Error adding transaction: $e");
    }
  }

  static Future<void> depositFromCard(BuildContext context, String walletID, double amount) async {
    try {
      
      // Wallet + amount, Card - amount
      String type = "Incoming";

      await WalletsTableManager.updateWalletBalance(context, walletID, amount, true);
      addTransaction(context, walletID, type, amount, userEmail!);

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Transaction was completed successfully',textAlign: TextAlign.center,)));

    } catch (e) {
      print("Error depositing from card: $e");
    }
  }

  static Future<void> depositFromUserBalance(BuildContext context, String walletID, double amount) async {
    try {
      
      // Wallet + amount, User Balance - amount

      String type = "Incoming";

      bool isUpdated = await UsersTableManager.updateUserBalance(context, userEmail!, amount, false);
      addTransaction(context, walletID, type, amount, userEmail!);

      if (isUpdated == false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Transaction was not completed',textAlign: TextAlign.center,)));
        return;
      }

      await WalletsTableManager.updateWalletBalance(context, walletID, amount, true);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Transaction was completed successfully',textAlign: TextAlign.center,)));

    } catch (e) {
      print("Error depositing from wallet: $e");
    }
  }

  static Future<void> withdrawToCard(BuildContext context, String walletID, double amount) async {
    try {

      // Wallet - amount, Card + amount

      String type = "Outcoming";

      await WalletsTableManager.updateWalletBalance(context, walletID, amount, false);
      addTransaction(context, walletID, type, amount, userEmail!);

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Transaction was completed successfully',textAlign: TextAlign.center,)));

    } catch (e) {
      print("Error withdrawing to card: $e");
    }
  }

  static Future<void> withdrawToUserBalance(BuildContext context, String walletID, double amount) async {
    try {

      // Wallet - amount, User Balance + amount

      String type = "Outcoming";

      bool isUpdated = await WalletsTableManager.updateWalletBalance(context, walletID, amount, false);
      addTransaction(context, walletID, type, amount, userEmail!);

      if (isUpdated == false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Transaction was not completed',textAlign: TextAlign.center,)));
        return;
      }

      await UsersTableManager.updateUserBalance(context, userEmail!, amount, true);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Transaction was completed successfully',textAlign: TextAlign.center,)));

    } catch (e) {
      print("Error withdrawing to wallet: $e");
    }
  }

  static Future<List<TransactionWallet>> getWalletTransactions(String walletID) async {
    List<TransactionWallet> transactions = [];
    try {
      var querySnapshot = await FirebaseFirestore.instance.collection('transactions').get();
      for (var transaction in querySnapshot.docs) {
        if (transaction.data()['walletID'] == walletID) {
          transactions.add(
            TransactionWallet(
              transactionID: transaction.data()['transactionID'],
              walletID: transaction.data()['walletID'],
              type: transaction.data()['type'],
              amount: transaction.data()['amount'].toDouble(),
              date: transaction.data()['date'],
              userEmail: transaction.data()['userEmail'],
              name: transaction.data()['name'],
            )
          );
        }
      }
    } catch (e) {
      print("Error getting transactions: $e");
    }
    return transactions;
  }

}