import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/Screens/Dashboard.dart';
import 'package:new_project/Screens/ViewPatient.dart';
import 'package:new_project/models/PatientModelProvider.dart';
import 'package:provider/provider.dart';

import '../Globals/localhost.dart';
import '../models/PatientModel.dart';

class AddPatient extends StatelessWidget {
  const AddPatient({Key? key});

  @override
  Widget build(BuildContext context) {
    return const AddPatientForm();
  }
}

class AddPatientForm extends StatefulWidget {
  const AddPatientForm({super.key});

  @override
  State<AddPatientForm> createState() => _AddPatientFormState();
}

class _AddPatientFormState extends State<AddPatientForm> {
  final TextEditingController _id = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _telephone = TextEditingController();
  final TextEditingController _age = TextEditingController();
  List<String> history = [];

  final formKey = GlobalKey<FormState>();

  // Define three boolean variables to track the checkboxes' state.
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientModelProvider>(
      builder: (context, patientProvider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text("Enter Patient Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
            backgroundColor: Colors.deepPurple,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Dashboard()));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        "Patient Details",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _id,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your NIC';
                          }
                          if (value.length != 10 && value.length != 12) {
                            return 'Please enter a valid NIC';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "National Identity Card"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextFormField(
                        controller: _name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Full Name"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _age,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your age';
                          }
                          // check if age is a number
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid age';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Age"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _telephone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your contact number';
                          }
                          if (value.length != 10) {
                            return 'Please enter a valid contact number';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Contact Number"),
                      ),
                    ),
                    // Checkbox for Medical History
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Medical History",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked1,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked1 = value!;
                                  });
                                },
                              ),
                              Text("Pressure"),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked2,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked2 = value!;
                                  });
                                },
                              ),
                              Text("Heart Problems"),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked3,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked3 = value!;
                                  });
                                },
                              ),
                              Text("Cholesterol"),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked4,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked4 = value!;
                                  });
                                },
                              ),
                              Text("Allergies"),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked5,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked5 = value!;
                                  });
                                },
                              ),
                              Text("Other"),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // --------------------------------- IMPORTANT FUNCTIONS--------------------------------------
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            // check null values
                            if (_id.text.isEmpty ||
                                _name.text.isEmpty ||
                                _age.text.isEmpty ||
                                _telephone.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please fill in all the required fields'),
                                ),
                              );

                            }

                            // if all are filled, add patient
                            else if (formKey.currentState!.validate()) {
                              await addPatient(patientProvider);
                            }
                            else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please fill in all the required fields correctly'),
                                  ),
                                );
                              }
                          },
                          label: const Text("Save Patient Details"),
                          icon: const Icon(Icons.save),
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> addPatient(patientProvider) async {
    history = [];
    if (isChecked1) {
      history.add('Pressure');
    }
    if (isChecked2) {
      history.add('Heart Problems');
    }
    if (isChecked3) {
      history.add('Cholesterol');
    }
    if (isChecked4) {
      history.add('Allergies');
    }
    if (isChecked5) {
      history.add('Other');
    }

    Patient patient = Patient(
      nic: _id.text,
      name: _name.text,
      age: _age.text,
      telephone: _telephone.text,
      history: history.join(', '),
    );

    // get current user JWT token
    User? user = FirebaseAuth.instance.currentUser;

    String? token = await user?.getIdToken();
    print(token);

    String localhost = Localhost.localhost;

    // // send the token to the backend in a POST request Authorization header as a Bearer token with patient details
    var response = await http.post(
      Uri.parse('$localhost:3000/createpatient'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'nic': patient.nic.toString(),
        'name': patient.name,
        'age': patient.age,
        'telephone': patient.telephone,
        'medical_history': patient.history.toString(),
      }),
    );

    print("Saved Patient Details");
    print(response.body);

    Map<String, dynamic> responseMap = json.decode(response.body);

    String patientId = responseMap['patient_id'];

    patient.patient_id = patientId;

    patientProvider.setPatient(patient);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ViewPatient(),
      ),
    );
  }
}
