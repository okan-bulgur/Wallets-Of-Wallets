// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'main_page.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {

  final Color customColor = Color(0xFF0A5440);

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallets of Wallets',
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: customColor),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Welcome Back !',
              style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w900, //makes LOGIN bold
                  color: customColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    filled: true,
                    fillColor: Color.fromARGB(100, 150, 150, 150),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          15.0), // Adjust the radius for curved edges
                      borderSide:
                          BorderSide.none, // Set the border color to gray
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    filled: true,
                    fillColor: Color.fromARGB(100, 150, 150, 150),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          15.0), // Adjust the radius for curved edges
                      borderSide:
                          BorderSide.none, // Set the border color to gray
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // Perform login authentication here
                    // For simplicity, let's just navigate to the main page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(customColor), // Change background color
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Adjust border radius
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 40.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Change text color
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    // Navigate to the register page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Don\'t have an account ? Sign Up',
                    style: TextStyle(
                      color: customColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
