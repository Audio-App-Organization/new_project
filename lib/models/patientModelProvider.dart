import 'package:flutter/cupertino.dart';
import 'package:new_project/models/patientModel.dart';


class PatientModelProvider extends ChangeNotifier{
  Patient patient = Patient(id: "", name: "", tpNumber: "", birthday: "", history: []);

void setPatient(Patient patient){
    this.patient = patient;
    notifyListeners();
  }

  void addRecording(String vowel, String recording){
    patient.addRecording(vowel, recording);
    notifyListeners();
  }

  void addHistory(String history){
    patient.history.add(history);
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