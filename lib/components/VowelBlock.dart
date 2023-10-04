import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/recorderService.dart';


class VowelRecorderBlock extends StatelessWidget {
  final String vowel;
  final String patientID;

  VowelRecorderBlock({required this.vowel, required this.patientID});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text("Voice Sample of '$vowel'",
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            )
          ),
        ),
        VowelRecorder(vowel: vowel, patientID: patientID, take: 1),
        VowelRecorder(vowel: vowel, patientID: patientID, take: 2),
        VowelRecorder(vowel: vowel, patientID: patientID, take: 3),
      ],
    );
  }
}
