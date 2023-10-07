import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/Globals/localhost.dart';
import 'package:new_project/Screens/UserProfile.dart';
import 'package:new_project/Screens/AddPatient.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/PatientModel.dart';
import '../models/PatientModelProvider.dart';
import '../models/userModel.dart';
import 'Login.dart';
import 'ViewPatient.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardPage();
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  UserModel user = UserModel(
    userId: "",
    therapistId: "",
    name: "",
    email: "",
    telephone: "",
    workplace: "",
  );
  List<Patient> patients = [];

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
    getPatients();
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

  void getPatients() async {
    // get token from Auth instance
    String? token = await FirebaseAuth.instance.currentUser!.getIdToken();

    // get localhost
    String localhost = Localhost.localhost;

    // Make the HTTP request
    var response = await http.get(
      Uri.parse('$localhost:3000/patients'),
      headers: {'Authorization': 'Bearer $token'}
    );

    print(response);

    if (response.statusCode == 200) {
      print("200");
      // If the server returns a 200 OK response,
      // parse the JSON
      List<dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
      List<Patient> jsonPatients =
          jsonResponse.map((data) => Patient.fromJson(data)).toList();

      setState(() {
        patients = jsonPatients;
      });

      print(patients);

    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load patients');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text("Patients"), actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ]),
      drawer: Drawer(
        child: ListView(
          children: [
            // add firebase details
            UserAccountsDrawerHeader(
              accountName: Text(user!.name.toString() != ""
                  ? user.name.toString()
                  : "No Name"),
              accountEmail: Text(user.email.toString() != ""
                  ? user.email.toString()
                  : "NoEmail"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  user.name.toString() != "" ? user.email.toString()[0] : "N",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserProfile()),
                ); // Close the drawer
                // Navigate to the profile page or perform other actions here
              },
            ),
            Divider(),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout"),
                onTap: () {
                  FirebaseAuth.instance.signOut();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                }),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.builder(
          itemCount: patients.length,
          itemBuilder: (context, index) {
            return _buildPatientCard(patients[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPatient()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPatientCard(Patient patient) {
    return Card(
      child: ListTile(
        title: Text(patient.name),
        subtitle: Text(patient.nic),
        onTap: () {
          // add patient to provider
          Provider.of<PatientModelProvider>(context, listen: false)
              .setPatient(patient);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ViewPatient(),
            ),
          );
          // Navigate to the patient details page
        },
        // Add more patient information or actions here if needed
      ),
    );
  }
}

