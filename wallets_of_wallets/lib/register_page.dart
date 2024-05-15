// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'data_base_manager.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Color customColor = Color(0xFF0A5440);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    final double appBarTitleSize = screenHeight * 0.04;
    final double signUpTitleSize = screenHeight * 0.05;
    final double buttonTextSize = screenHeight * 0.02;
    final double loginTextSize = screenHeight * 0.02;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallets of Wallets',
          style: TextStyle(
            fontSize: appBarTitleSize,
            fontWeight: FontWeight.bold,
            color: customColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            children: <Widget>[
              SizedBox(height: screenHeight * 0.1),
              Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: signUpTitleSize,
                    fontWeight: FontWeight.w900,
                    color: customColor,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  fillColor: Color.fromARGB(100, 150, 150, 150),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenHeight * 0.03),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                controller: surnameController,
                decoration: InputDecoration(
                  labelText: 'Surname',
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  fillColor: Color.fromARGB(100, 150, 150, 150),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenHeight * 0.03),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  filled: true,
                  fillColor: Color.fromARGB(100, 150, 150, 150),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenHeight * 0.03),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  filled: true,
                  fillColor: Color.fromARGB(100, 150, 150, 150),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenHeight * 0.03),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: screenHeight * 0.04),
              ElevatedButton(
                onPressed: () {
                  AuthenticationManager.signup(
                    context,
                    nameController.text,
                    surnameController.text,
                    emailController.text,
                    passwordController.text,
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(customColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(screenHeight * 0.04),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                    horizontal: screenWidth * 0.1,
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: buttonTextSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    color: customColor,
                    fontSize: loginTextSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}