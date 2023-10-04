class Patient {
  final String id;
  final String name;
  final String birthday;
  final String tpNumber;
  final List<String> history;
  Map<String, List<String>> recordings = {
    'a': [],
    'e': [],
    'i': [],
    'o': [],
    'u': [],
  };

  Patient({
    required this.id,
    required this.name,
    required this.birthday,
    required this.tpNumber,
    required this.history,
  });

  void addRecording(String vowel, String recording) {
    recordings[vowel]!.add(recording);
  }
}
