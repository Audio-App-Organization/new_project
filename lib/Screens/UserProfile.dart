import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Globals/localhost.dart';
import '../models/PatientModel.dart';
import '../models/userModel.dart';
import 'Login.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const UserProfilePage();
  }
}

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfilePage> {
  UserModel user = UserModel(
    userId: "",
    therapistId: "",
    name: "",
    email: "",
    telephone: "",
    workplace: "",
  );


  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  void _loadUserDetails() async {
    try {
      user = await getUserDetails();
      setState(() {
        user = user;
      });
    } catch (e) {
      // Handle error (e.g., display an error message)
      print('Error loading user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirm Delete"),
                    content:
                    Text("Are you sure you want to delete your account?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: deleteuser,
                        child: Text("Delete"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildTitleSubtitlePair("Therapist ID", "${user.therapistId}"),
          buildTitleSubtitlePair("Name", "${user.name}"),
          buildTitleSubtitlePair("Email", "${user.email}"),
          buildTitleSubtitlePair("Telephone", "${user.telephone}"),
          buildTitleSubtitlePair("Workplace", "${user.workplace}"),
        ],
      ),
    );
  }
  // delete user function with delete firebase account, and call backend /deleteuser
  void deleteuser() async {
    // get token from Auth instance
    String? token = await FirebaseAuth.instance.currentUser!.getIdToken();

    // get localhost
    String localhost = Localhost.localhost;

    // Make the HTTP request
    var response = await http.delete(
      Uri.parse('$localhost:3000/deleteuser'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      // user is deleted successfully from backend

      // delete user from firebase
      FirebaseAuth.instance.currentUser!.delete();

      // navigate to login page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );

      // give bottom alert saying user deleted
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User deleted'),
        ),
      );

    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load user details');
    }
  }
}

Future<UserModel> getUserDetails() async {
  // get token from Auth instance
  String? token = await FirebaseAuth.instance.currentUser!.getIdToken();

  print(token);

  // get localhost
  String localhost = Localhost.localhost;

  // Make the HTTP request
  var response = await http.get(
    Uri.parse('$localhost:3000/user'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response,
    // parse the JSON
    Map<String, dynamic> jsonResponse = json.decode(response.body);

    // Create a user model
    UserModel user = UserModel(
      userId: jsonResponse['user_id'],
      therapistId: jsonResponse['therapist_id'],
      name: jsonResponse['name'],
      email: jsonResponse['email'],
      telephone: jsonResponse['telephone'],
      workplace: jsonResponse['workplace'],
    );

    // Now you can use the 'user' object as needed
    print(user.name);
    return user;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load user details');
  }
}

Widget buildTitleSubtitlePair(String topic, String data) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    child: Column(
      children: [
        Text(
          topic,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          data,
          style: TextStyle(fontSize: 24),
        ),
      ],
    ),
  );
}

