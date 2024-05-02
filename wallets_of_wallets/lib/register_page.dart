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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallets of Wallets',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: customColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 130.0),
              Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w900,
                    color: customColor,
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  fillColor: Color.fromARGB(100, 150, 150, 150),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0), // Adjust the radius for curved edges
                    borderSide: BorderSide.none, // Set the border color to gray
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: surnameController,
                decoration: InputDecoration(
                  labelText: 'Surname',
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  fillColor: Color.fromARGB(100, 150, 150, 150),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0), // Adjust the radius for curved edges
                    borderSide: BorderSide.none, // Set the border color to gray
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  filled: true,
                  fillColor: Color.fromARGB(100, 150, 150, 150),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0), // Adjust the radius for curved edges
                    borderSide: BorderSide.none, // Set the border color to gray
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  filled: true,
                  fillColor: Color.fromARGB(100, 150, 150, 150),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0), // Adjust the radius for curved edges
                    borderSide: BorderSide.none, // Set the border color to gray
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  DataBaseManager.signup(context, nameController.text, surnameController.text, emailController.text, passwordController.text);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(customColor), // Change background color
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Adjust border radius
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Change text color
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    color: customColor,
                    fontSize: 16.0,
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