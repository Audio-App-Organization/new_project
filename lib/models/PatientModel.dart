class Patient {
  late final String patient_id;
  final String nic;
  final String name;
  final String age;
  final String telephone;
  final String history;
  Map<String, List<String>> recordings = {
    'a': [],
    'i': [],
    'u': [],
  };
  late String comment;

  Patient({
    required this.nic,
    required this.name,
    required this.age,
    required this.telephone,
    required this.history,
  });

  Patient.fromJson(Map<String, dynamic> json)
      : patient_id = json['patient_id'],
        nic = json['nic'],
        name = json['name'],
        age = json['age'].toString(),
        telephone = json['telephone'],
        history = json['medical_history'];


  void addRecording(String vowel, String recording) {
    recordings[vowel]!.add(recording);
  }

}
