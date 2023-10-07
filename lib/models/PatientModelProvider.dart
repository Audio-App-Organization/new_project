import 'package:flutter/cupertino.dart';
import 'package:new_project/models/PatientModel.dart';


class PatientModelProvider extends ChangeNotifier {
  Patient patient = Patient(nic: "",
      name: "",
      telephone: "",
      age: "",
      history: "");


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


}