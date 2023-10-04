import 'package:flutter/material.dart';
import 'package:new_project/Showdetails.dart';

import 'models/patientModel.dart';

class AddPatient extends StatelessWidget {
  const AddPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AddPatientForm(),
    );
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
  final TextEditingController _tpnumber = TextEditingController();
  final TextEditingController _birthday = TextEditingController();

  List<String> history = [];

  // Define three boolean variables to track the checkboxes' state.
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;

  @override
  Widget build(BuildContext context) {
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
            Navigator.pop(context);
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  "Patient Details",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: TextField(
                  controller: _id,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Enter NIC"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: TextField(
                  controller: _name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter Name with Initials"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: TextField(
                  controller: _birthday,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Age"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: TextField(
                  controller: _tpnumber,
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
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      navigateToShowDetails();
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
              )
            ],
          ),
        ),
      ),
    );
  }
  void navigateToShowDetails() {

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
      id: _id.text,
      name: _name.text,
      birthday: _birthday.text,
      tpNumber: _tpnumber.text,
      history: history,
    );




    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ShowDetails(
          patient: patient,
        ),
      ),
    );
  }



}
