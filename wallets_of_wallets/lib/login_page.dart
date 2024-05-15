// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'data_base_manager.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Color customColor = Color(0xFF0A5440);

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    final double titleFontSize = screenWidth * 0.08;
    final double welcomeFontSize = screenWidth * 0.08;
    final double textFieldHeight = screenHeight * 0.06;
    final double buttonHeight = screenHeight * 0.055;
    final double buttonWidth = screenWidth * 0.6;
    final double buttonTextFontSize = screenWidth * 0.04;
    final double signUpFontSize = screenWidth * 0.04;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallets of Wallets',
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: customColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            child: Text(
              'Welcome Back !',
              style: TextStyle(
                fontSize: welcomeFontSize,
                fontWeight: FontWeight.w900,
                color: customColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              children: [
                SizedBox(
                  height: textFieldHeight,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Color.fromARGB(100, 150, 150, 150),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(
                  height: textFieldHeight,
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      filled: true,
                      fillColor: Color.fromARGB(100, 150, 150, 150),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                SizedBox(
                  height: buttonHeight,
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () async {
                      AuthenticationManager.login(
                        context,
                        emailController.text,
                        passwordController.text,
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(customColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 40.0,
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: buttonTextFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                TextButton(
                  onPressed: () {
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
                      fontSize: signUpFontSize,
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
