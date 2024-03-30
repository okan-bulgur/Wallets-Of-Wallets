// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'main_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wallets of Wallets',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 54, 106, 57)
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
                    color: Color.fromARGB(255, 54, 106, 57),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              TextField(
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
                  // Perform registration logic here
                  // For simplicity, let's just navigate to the main page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 50, 97, 52)), // Change background color
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
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    color: Color.fromARGB(255, 77, 125, 79),
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


class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Perform registration logic here
              // For simplicity, let's just navigate to the main page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(),
                ),
              );
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
