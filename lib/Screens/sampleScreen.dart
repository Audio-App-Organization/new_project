import 'package:flutter/material.dart';
import 'package:new_project/Classifier.dart';
import 'package:new_project/models/patientModel.dart';
import '../components/VowelBlock.dart';

class SampleScreen extends StatelessWidget {
  final Patient patient;

  const SampleScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          leading: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          title: const Text('Record Voice Samples'),

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
                          color: Colors.deepPurple, // You can change the color here
                        ),
                      ),

                      TextSpan(text: "\n"),
                      TextSpan(text: 'Keep the mobile phone 10cm away from the patient, and take 03 voice samples for each vowel sound.'),
                    ],
                  ),
                )
                ,
              ),

              // pass the model by reference to the VowelRecorderBlock, without making a copy
              VowelRecorderBlock(vowel: 'a', patientID: "1234"),
              VowelRecorderBlock(vowel: 'e', patientID: "1234"),
              VowelRecorderBlock(vowel: 'i', patientID: "1234"),
            ],
          ),
        ),
      ),
    );
  }

}
