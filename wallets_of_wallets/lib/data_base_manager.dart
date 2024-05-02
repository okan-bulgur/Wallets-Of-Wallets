import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstly/login_page.dart';
import 'main_page.dart';
import 'package:flutter/material.dart';

class DataBaseManager {
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
