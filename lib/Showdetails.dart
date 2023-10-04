import 'package:flutter/material.dart';
import 'package:new_project/Screens/sampleScreen.dart';
import 'package:new_project/models/patientModelProvider.dart';
import 'package:provider/provider.dart';

import 'models/patientModel.dart';

class ShowDetails extends StatelessWidget {
  const ShowDetails({super.key});

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
                  Navigator.pop(context);
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
                    onPressed: () {})
              ]),
          body: Stack(children: [
            ListView(
              children: [
                ListTile(
                  title: Text("ID Number"),
                  subtitle: Text(patient.id),
                ),
                ListTile(
                  title: Text("Name"),
                  subtitle: Text(patient.name),
                ),
                ListTile(
                  title: Text("Age"),
                  subtitle: Text(patient.birthday),
                ),
                ListTile(
                  title: Text("Telephone Number"),
                  subtitle: Text(patient.tpNumber),
                ),
                ListTile(
                  title: Text("Medical History"),
                  subtitle: Text(patient.history.join(', ')),
                ),
                Text("Voice Samples",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  ),

                ListTile(
                  title: Text("Vowel A"),
                  subtitle: Text(patient.recordings['a'].toString()),
                ),
                ListTile(
                  title: Text("Vowel E"),
                  subtitle: Text(patient.recordings['e'].toString()),
                ),
                ListTile(
                  title: Text("Vowel I"),
                  subtitle: Text(patient.recordings['i'].toString()),
                ),
                ListTile(
                  title: Text("Vowel O"),
                  subtitle: Text(patient.recordings['o'].toString()),
                ),
                ListTile(
                  title: Text("Vowel U"),
                  subtitle: Text(patient.recordings['u'].toString()),
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
}
