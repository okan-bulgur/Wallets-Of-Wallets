import 'package:flutter/material.dart';
import 'package:firstly/login_page.dart';
import 'main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseApp app = Firebase.app();

class AuthenticationManager {
  static login(BuildContext context, email, String password) async {
    try {
        print("Email: ${email}, Password: ${password}");
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // If login successful, navigate to the main page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      } catch (e) {
        // Handle login errors (e.g., display error message)
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

  static Future<void> deleteUser(String email) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(email).delete();
    } catch (e) {
      print("Error deleting user: $e");
    }
  }

  static Future<void> updateUser(String name, String surname, String email) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(email).update({
        'name': name,
        'surname': surname,
      });
    } catch (e) {
      print("Error updating user: $e");
    }
  }

  static Future<void> getUser(String email) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(email).get();
    } catch (e) {
      print("Error getting user: $e");
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
        'color': walletColor.value.toString(),
        'list_of_admins': [email],
        'list_of_members': [],
        'list_of_transactions': []
      });
      await FirebaseFirestore.instance.collection('users').doc(email).update({
        'list_of_wallets': FieldValue.arrayUnion([walletID])
      });
    } catch (e) {
      print("Error adding wallet: $e");
    }
  }

  static Future<void> deleteWallet(String walletID) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).delete();

      for (var member in await FirebaseFirestore.instance.collection('wallets').doc(walletID).get().then((value) => value.data()!['list_of_members'])) {
        await FirebaseFirestore.instance.collection('users').doc(member).update({
          'list_of_wallets': FieldValue.arrayRemove([walletID])
        });
      }

      for (var admin in await FirebaseFirestore.instance.collection('wallets').doc(walletID).get().then((value) => value.data()!['list_of_admins'])) {
        await FirebaseFirestore.instance.collection('users').doc(admin).update({
          'list_of_wallets': FieldValue.arrayRemove([walletID])
        });
      }

    }
    catch (e) {
      print("Error deleting wallet: $e");
    }
  }

  static Future<void> updateWalletSettings(String walletID, String walletName, String walletDescription, Color walletColor) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).update({
        'name': walletName,
        'description': walletDescription,
        'color': walletColor.value.toString(),
      });
    } catch (e) {
      print("Error updating wallet: $e");
    }
  }

  static Future<void> getWallet(String walletID) async {
    try {
      await FirebaseFirestore.instance.collection('wallets').doc(walletID).get();
    } catch (e) {
      print("Error getting wallet: $e");
    }
  }
}