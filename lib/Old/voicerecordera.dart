import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:new_project/Old/Voicei.dart';
import 'package:record/record.dart';

class Voice extends StatefulWidget {
  const Voice({super.key});

  @override
  State<Voice> createState() => _VoiceState();
}

class _VoiceState extends State<Voice> {
  late Record audioRecord;
  bool isRecording = false;
  String audioPath = '';
  int currentSample = 1; // Keeps track of the current sample being recorded.
  late String audioFolderPath;

  @override
  void initState() {
    audioRecord = Record();
    _initializeAudioFolderPath();
    super.initState();
  }

  Future<void> _initializeAudioFolderPath() async {
    final directory = await getExternalStorageDirectory();
    audioFolderPath = '${directory?.path}/Audio';
    Directory(audioFolderPath).create(recursive: true);
  }

  @override
  void dispose() {
    audioRecord.dispose();
    super.dispose();
  }


  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        setState(() {
          isRecording = true;
        });

        Future.delayed(const Duration(seconds: 4), () {
          if (isRecording) {
            stopRecording();
          }
        });
      }
    } catch (e) {
      print('Error Start Recording : $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      setState(() {
        isRecording = false;
        audioPath = path!;
      });

      String audioFileName = 'sample_$currentSample.wav';
      String audioFilePath = '$audioFolderPath/$audioFileName';

      File audioFile = File(audioPath);
      await audioFile.rename(audioFilePath);

      if (currentSample < 5) {
        setState(() {
          currentSample++;
        });
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Voicei()),
        );
      }
    } catch (e) {
      print('Error Stopping record : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Voice Sample'),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Column(
                children: <Widget>[
                  Text(
                    "Voice Samples of Vowel Sound a",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    " 'INSTRUCTIONS: Keep the mobile phone 10cm away from the patient, and take 05 voice samples from the vowel sound 'a'. Then click Next>>> '",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: isRecording ? stopRecording : startRecording,
                    child: isRecording
                        ? const Text('Stop Recording')
                        : Text('Start Recording: Sample $currentSample'),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Voicei()),
                      );
                    },
                    child: const Text("Next >>>"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}