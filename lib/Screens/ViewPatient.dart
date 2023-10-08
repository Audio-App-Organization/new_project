import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/Screens/Dashboard.dart';
import 'package:new_project/Screens/VoiceSampleScreen.dart';
import 'package:new_project/models/PatientModelProvider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../Globals/localhost.dart';
import '../models/PatientModel.dart';

class ViewPatient extends StatelessWidget {
  const ViewPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return const PatientDetailsPage();
  }
}

class PatientDetailsPage extends StatefulWidget {
  const PatientDetailsPage({Key? key}) : super(key: key);

  @override
  State<PatientDetailsPage> createState() => _PatientDetailsState();
}


class _PatientDetailsState extends State<PatientDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientModelProvider>(
      builder: (context, patientModelProvider, child) {
        Patient patient = patientModelProvider.patient;
        return Scaffold(
          appBar: AppBar(
              title: const Text("Patient Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              backgroundColor: Colors.deepPurple,
              leading: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.white,
                    onPressed: () {}),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.white,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirm Delete"),
                          content: Text(
                              "Are you sure you want to delete your account?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: deletepatient,
                              child: Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ]),
          body: Stack(children: [
            ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Text(
                    "Patient Details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Patient ID"),
                  subtitle: Text(patient.patient_id),
                ),
                ListTile(
                  title: Text("ID Number"),
                  subtitle: Text(patient.nic),
                ),
                ListTile(
                  title: Text("Name"),
                  subtitle: Text(patient.name),
                ),
                ListTile(
                  title: Text("Age"),
                  subtitle: Text(patient.age),
                ),
                ListTile(
                  title: Text("Telephone Number"),
                  subtitle: Text(patient.telephone),
                ),
                ListTile(
                  title: Text("Medical History"),
                  subtitle: Text(patient.history),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Text(
                    "Voice Samples",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Vowel A"),
                  subtitle: Text(patient.recordings['a']!.join(',')),
                ),
                ListTile(
                  title: Text("Vowel E"),
                  subtitle: Text(patient.recordings['e']!.join(',')),
                ),
                ListTile(
                  title: Text("Vowel I"),
                  subtitle: Text(patient.recordings['i']!.join(',')),
                ),
                ListTile(
                  title: Text("Vowel O"),
                  subtitle: Text(patient.recordings['o']!.join(',')),
                ),
                ListTile(
                  title: Text("Vowel U"),
                  subtitle: Text(patient.recordings['u']!.join(',')),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    color: Colors.white, // Background color for the button row
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            // make the recordings in model empty
                            patientModelProvider.clearRecordings();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SampleScreen(),
                              ),
                            );
                          },
                          label: const Text("Add Voice Samples"),
                          icon: const Icon(Icons.settings_voice),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            minimumSize: const Size(200, 50),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        );
      },
    );
  }

  void deletepatient() async {


    String? token = await FirebaseAuth.instance.currentUser!.getIdToken();
    // get localhost
    String localhost = Localhost.localhost;


    // Make the HTTP request with patient_id in body
    var response = await http.delete(
      Uri.parse('$localhost:3000/deletepatient'),
      headers: {'Authorization': 'Bearer $token'},
      body: {'patient_id': Provider.of<PatientModelProvider>(context, listen: false).patient.patient_id},
    );

    if (response.statusCode == 200) {

      // delete patient from provider
      Provider.of<PatientModelProvider>(context, listen: false).setPatient(Patient(nic: "",
        name: "",
        telephone: "",
        age: "",
        history: ""));

      // add "" to patient_id in provider
      Provider.of<PatientModelProvider>(context, listen: false).patient.patient_id = "";

      // redirect to home page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );

      // give bottom alert saying user deleted
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Patient deleted'),
        ),
      );

    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to delete patient');
    }
  }
}

