import 'package:wallets_of_wallets/SignUpPage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  late String username ;
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
              "Wallets of wallets", // Replace with your desired text
              style: TextStyle(
                fontSize: 26.0,
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
                    children:<Widget>[ 
                      
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 35.0 ,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 14, 83, 17),
                        ),
                        ),
                      const SizedBox(height: 15.0,),
                      
                      const Text(
                        "Enter your credential to login",
                        style: TextStyle(
                          fontSize: 20.0 ,
                          color: Color.fromARGB(255, 14, 83, 17),
                        ),
                        ),
                      const SizedBox(height: 15.0,),

                      TextFormField(
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)
                          ),
                          hintText: "name@email.com",
                          border: OutlineInputBorder()
                        ),
                        onSaved: (value){
                          username = value! ;
                        },
                      ),
                      SizedBox(height: 10.0,),
                      
                      TextFormField(
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)
                          ),
                          hintText: "password",
                          border: OutlineInputBorder()
                        ),
                        onSaved: (value){
                          username = value! ;
                        },
                      ),
                      MaterialButton(
                        child: Text("Login") ,
                        onPressed: () {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account"),
                          MaterialButton(
                            child: Text("Sign Up"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpPage()),
                              );
                            },
                          ),
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
