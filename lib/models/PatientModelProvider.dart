import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_project/models/PatientModel.dart';

import 'package:http/http.dart' as http;

import '../Globals/localhost.dart';

class PatientModelProvider extends ChangeNotifier {
  Patient patient =
      Patient(nic: "", name: "", telephone: "", age: "", history: "");

  void setPatient(Patient patient) {
    this.patient = patient;
    notifyListeners();
  }

  void addRecording(String vowel, String recording) {
    patient.addRecording(vowel, recording);
    notifyListeners();
  }

  void updateRecordingResult(String vowel, String result) {
    // Check if the patient exists in the recordings map
    if (patient.recordings.containsKey(vowel)) {
      // If the patient exists, update the result
      patient.recordings.update(vowel, (value) => [result]);
    } else {
      // If the patient does not exist, add the patient to the map
      patient.recordings.putIfAbsent(vowel, () => [result]);
    }
  }

  Future<void> updateDatabase() async {
    // update database with vowel results
    String? token = await FirebaseAuth.instance.currentUser!.getIdToken();

    // get localhost
    String localhost = Localhost.localhost;

    // Make the HTTP request
    var response = await http.post(
      Uri.parse('$localhost:3000/createreport'),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        'patient_id': patient.patient_id,
        'a': patient.recordings['a']!.join(','),
        'e': patient.recordings['e']!.join(','),
        'i': patient.recordings['i']!.join(','),
        'o': patient.recordings['o']!.join(','),
        'u': patient.recordings['u']!.join(','),
      },
    );

    // if 200
    if (response.statusCode == 200) {
      print("200");

      //
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load patients');
    }
  }

  void clearRecordings() {
    patient.recordings = {
      'a': [],
      'e': [],
      'i': [],
      'o': [],
      'u': [],
    };
    notifyListeners();
  }
}
