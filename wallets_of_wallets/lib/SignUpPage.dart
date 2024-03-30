import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  
  late String name;
  late String surname;
  late String email ;
  late String password ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 100.0),
            alignment: Alignment.center,
            child: const Text(
              "Wallets of Wallets",
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 14, 83, 17),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 14, 83, 17),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      const Text(
                        "Create your account",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Color.fromARGB(255, 14, 83, 17),
                        ),
                      ),
                      const SizedBox(height: 15.0),

                      TextFormField(
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            hintText: "name",
                            border: OutlineInputBorder()),
                        onSaved: (value) {
                          name = value!;
                        },
                      ),
                      SizedBox(height: 10.0),


                      TextFormField(
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            hintText: "surname",
                            border: OutlineInputBorder()),
                        onSaved: (value) {
                          surname = value!;
                        },
                      ),
                      SizedBox(height: 10.0),

                      TextFormField(
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            hintText: "name@email.com",
                            border: OutlineInputBorder()),
                        onSaved: (value) {
                          email = value!;
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            hintText: "password",
                            border: OutlineInputBorder()),
                        onSaved: (value) {
                          password = value!;
                        },
                      ),
                      
                      MaterialButton(
                        child: Text("Sign Up"),
                        onPressed: () {},
                      ),
                      
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Log In"),
                          )
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
