import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/Globals/localhost.dart';
import 'package:new_project/Screens/AddPatient.dart';
import 'package:new_project/Screens/UserProfile.dart';
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
  List<Patient> searchResults = [];

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
    getPatients();
    // dummyPatients();
    searchResults = patients;
  }

  // search function with ID or Name
  void search(String query) {
    List<Patient> results = [];
    // Search algorithm
    print("searching");
    if (query != "") {
      for (int i = 0; i < patients.length; i++) {
        if (patients[i].name.toLowerCase().contains(query.toLowerCase()) ||
            patients[i].nic.toLowerCase().contains(query.toLowerCase())) {
          results.add(patients[i]);
          print("found");
        }
      }
    } else {
      results = patients;
    }

    setState(() {
      searchResults = results;
    });
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

  String generateRandomNIC() {
    Random random = Random();
    String nic = '';

    for (int i = 0; i < 10; i++) {
      nic += random.nextInt(10).toString();
    }

    return nic;
  }

  void getPatients() async {
    // get token from Auth instance
    String? token = await FirebaseAuth.instance.currentUser!.getIdToken();

    // get localhost
    String localhost = Localhost.localhost;

    // Make the HTTP request
    var response = await http.get(Uri.parse('$localhost:3000/patients'),
        headers: {'Authorization': 'Bearer $token'});

    print(response);

    if (response.statusCode == 200) {
      print("200");
      // If the server returns a 200 OK response,
      // parse the JSON
      List<dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
      List<Patient> jsonPatients =
          jsonResponse.map((data) => Patient.fromJson(data)).toList();

      print("Patient 01 Name: ${jsonPatients[0].name}");

      setState(() {
        patients = jsonPatients;
        searchResults = jsonPatients;
      });

    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load patients');
    }
  }
  //
  // void dummyPatients() {
  //   List<Patient> dummyPatient = [];
  //   for (int i = 0; i < 10; i++) {
  //     //random 10 random digits for single nic number string
  //     String nic = generateRandomNIC();
  //
  //     Patient patient = Patient(
  //       nic: nic,
  //       name: 'Patient $i',
  //       age: '30',
  //       telephone: '123456789',
  //       history: 'No significant medical history',
  //     );
  //     dummyPatient.add(patient);
  //   }
  //
  //   setState(() {
  //     patients = dummyPatient;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Patients"),
      ),
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
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search by ID or Name',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              search(value);
            },
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return _buildPatientCard(searchResults[index]);
                  })),
        ],
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
