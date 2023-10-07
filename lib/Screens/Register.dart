import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/Screens/Dashboard.dart';

import '../Globals/localhost.dart';
import 'Login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? confirmPasswordError;

  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final idController = TextEditingController();
  final NameController = TextEditingController();
  final ConfirmpassController = TextEditingController();
  final TPnumberController = TextEditingController();
  final PlaceController = TextEditingController();
  bool passToggle = true;

  bool _isValidEmail(String email) {
    // Define a regular expression for email validation
    final RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  // Add user to database while registering using firestore
  Future<void> registerWithFirebase() async {
    try {
      String? emailAddress = emailController.text;

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );

      // extract that JWT token from the userCredential object
      String? token = await userCredential.user!.getIdToken();
      print(token);

      String? hostip = Localhost.localhost;

      // send the token to the backend in a POST request Authorization header as a Bearer token
      var response = await http.post(
        Uri.parse('$hostip:3000/createuser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'therapist_id': idController.text,
          'name': NameController.text,
          'email': emailAddress,
          'telephone': TPnumberController.text,
          'workplace': PlaceController.text,
        }),
      );
      print(response);
      print("Account Created");



      // login with firebase with the created account.
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );

      emailController.clear();
      passController.clear();
      ConfirmpassController.clear();
      TPnumberController.clear();
      PlaceController.clear();
    } catch (e) {
      print('Error in Registration: $e');
    }

    // redirect to main.dart
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Dashboard(),
      ),
    );
  }

  void _showLoginSuccessDialog(BuildContext context) {
    if (_formfield.currentState!.validate()) {
      if (passController.text != ConfirmpassController.text) {
        setState(() {
          confirmPasswordError = "Passwords do not match";
        });
      } else {
        setState(() {
          confirmPasswordError = null;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text("You have Successfully Registered in"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    ); // Close the dialog
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              const Text(
                "Register",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Create Account",
                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              ),
              Form(
                key: _formfield,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: idController,
                      decoration: InputDecoration(
                        labelText: "TherapistID",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter ID";
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: NameController,
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter ID";
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email";
                        } else if (!_isValidEmail(value)) {
                          return "Enter a valid Email";
                        }
                        return null; // No error
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: passController,
                      obscureText: passToggle,
                      decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Icon(passToggle
                                ? Icons.visibility
                                : Icons.visibility_off),
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: ConfirmpassController,
                      obscureText: passToggle,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              passToggle = !passToggle;
                            });
                          },
                          child: Icon(passToggle
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        } else if (value != passController.text) {
                          return "Passwords do not match";
                        }
                        return null; // No error
                      },
                    ),
                    Text(
                      confirmPasswordError ?? '',
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: TPnumberController,
                      decoration: const InputDecoration(
                        labelText: "Telephone Number",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter A Telephone Number";
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: PlaceController,
                      decoration: const InputDecoration(
                        labelText: "Work Place/ Hospital",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter ID";
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: registerWithFirebase,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already Have an Account?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Create a widget for text field
Widget inputFile({label, obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[400]!,
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}
