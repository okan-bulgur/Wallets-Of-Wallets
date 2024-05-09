// ignore_for_file: dead_code

import 'package:firstly/Wallets/wallet.dart';
import 'package:firstly/Wallets/walletManager.dart';
import 'package:flutter/material.dart';
import 'package:firstly/login_page.dart';
import 'main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseApp app = Firebase.app();
String? userEmail;

class AuthenticationManager {
  static login(BuildContext context, email, String password) async {
    try {
        print("Email: ${email}, Password: ${password}");
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        userEmail = FirebaseAuth.instance.currentUser!.email;
        
        // If login successful, navigate to the main page
        List<Wallet> wallets = await WalletsTableManager.getUserWallets(email);
        print(wallets.length);
        WalletManager.setUsersWallets(wallets);
        
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
      print("name: ${name}, surname: ${surname} Email: ${email}, Password: ${password}");
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
        'list_of_wallets': Map<String, bool>()
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

      List<Wallet> wallets = await WalletsTableManager.getUserWallets(userEmail!);
      WalletManager.setUsersWallets(wallets);
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

}

class WalletsTableManager{
  
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
        'list_of_transactions': []
      });
      await FirebaseFirestore.instance.collection('users').doc(email).update({
        'list_of_wallets': FieldValue.arrayUnion([walletID])
      });

      WalletManager.generateWallet(walletColor, walletName, walletDescription, walletID, 0, 0);
    } catch (e) {
      print("Error adding wallet: $e");
    }
  }

  static Future<void> addMemberToWallet(String walletID) async {
    try {
      print("Adding member to wallet: $userEmail id: $walletID");
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).update({
        'list_of_members': FieldValue.arrayUnion([userEmail])
      });
      print("Added member to wallet: $userEmail");
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
        print("Wallet found");
        bool isUserAdmin = await WalletsTableManager.isUserAdminOfWallet(walletID);
        bool isUserMember = await WalletsTableManager.isUserMemberOfWallet(walletID);
        print(isUserAdmin);
        print(isUserMember);
        if (isUserAdmin || isUserMember) {
          print("User is already in the wallet");
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

      List<Wallet> wallets = await WalletsTableManager.getUserWallets(userEmail!);
      WalletManager.setUsersWallets(wallets);

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
      WalletManager.updateWalletName(name);
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
      WalletManager.updateWalletDescription(description);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Description of wallet updated successfully',textAlign: TextAlign.center)));
    } catch (e) {
      print("Error updating wallet balance: $e");
    }
  }

  static Future<void> updateWalletPaymentAmount(BuildContext context, String walletID, double payment_amount) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).update({
        'payment_amount': payment_amount,
      });
      WalletManager.updateWalletPaymentAmount(payment_amount);
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
      WalletManager.updateWalletColor(color);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Color of wallet updated successfully',textAlign: TextAlign.center)));
    } catch (e) {
      print("Error updating wallet balance: $e");
    }
  }

  static Future<List<Wallet>> getUserWallets(String email) async {
    List<Wallet> wallets = [];
    try {
      await FirebaseFirestore.instance.collection('users').doc(email).get().then((value) async {
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
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).get().then((value) {
        if (value.data()!['list_of_admins'].contains(userEmail)) {
          return true;
        }
      });
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

  static Future<void> removeUserFromWallet(String walletID, String userEmail) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).update({
        'list_of_admins': FieldValue.arrayRemove([userEmail]),
        'list_of_members': FieldValue.arrayRemove([userEmail])
      });
    } catch (e) {
      print("Error removing user from wallet: $e");
    }
  }



}