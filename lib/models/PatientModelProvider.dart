import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/models/PatientModel.dart';

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

    notifyListeners();
  }

  Future<void> updateDatabase() async {
    // update database with vowel results
    try {
      String? token = await FirebaseAuth.instance.currentUser!.getIdToken();

      print("$token");

      // get localhost
      String localhost = Localhost.localhost;

      print("$localhost:3000/createreport");

      // Make the HTTP request
      var response = await http.post(
        Uri.parse('$localhost:3000/createreport'),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'patient_id': patient.patient_id,
          'a': patient.recordings['a']!.join(','),
          'i': patient.recordings['i']!.join(','),
          'u': patient.recordings['u']!.join(','),
          'comment': patient.comment,
        },
      );

      print("Request sent to server: $response");

      // if 200
      if (response.statusCode == 200) {
        print("200");

        //
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to store patient data');
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void clearRecordings() {
    patient.recordings = {
      'a': [],
      'i': [],
      'u': [],
    };
    notifyListeners();
  }

  //set comment
  void setComment(String comment) {
    patient.comment = comment;
    notifyListeners();
  }
}
