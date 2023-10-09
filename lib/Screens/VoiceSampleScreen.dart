import 'package:flutter/material.dart';
import 'package:new_project/models/PatientModelProvider.dart';
import 'package:provider/provider.dart';

import '../components/VowelBlock.dart';
import 'CreatePDF.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientModelProvider>(
        builder: (context, patientModelProvider, child) {
      String patient_id = patientModelProvider.patient.patient_id;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: const Text('Record Voice Samples'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                // save the patient details
                // patientModelProvider.updateDatabase();
                print("Button Pressed");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreatePDF(),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'INSTRUCTIONS: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .deepPurple, // You can change the color here
                        ),
                      ),
                      TextSpan(text: "\n"),
                      TextSpan(
                          text:
                              'Keep the mobile phone 10cm away from the patient, and take 03 voice samples for each vowel sound.'),
                    ],
                  ),
                ),
              ),

              // pass the model by reference to the VowelRecorderBlock, without making a copy
              VowelRecorderBlock(vowel: 'a', patientID: patient_id),
              VowelRecorderBlock(vowel: 'i', patientID: patient_id),
              VowelRecorderBlock(vowel: 'u', patientID: patient_id),
            ],
          ),
        ),
      );
    });
  }
}
