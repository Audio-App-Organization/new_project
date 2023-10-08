import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:new_project/models/PatientModelProvider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

import '../Globals/localhost.dart';
import '../models/PatientModel.dart';
import '/services/UploadService.dart';

class VowelRecorder extends StatefulWidget {
  final String vowel;
  final String patientID;
  final int take;

  const VowelRecorder(
      {super.key,
      required this.vowel,
      required this.patientID,
      required this.take});

  @override
  State<VowelRecorder> createState() => _VowelRecorderState();
}

class _VowelRecorderState extends State<VowelRecorder> {
  late Record _record;
  late AudioPlayer _audioPlayer;
  bool isRecording = false;
  String audioPath = "";
  String result = "pending";

  @override
  void initState() {
    _record = Record();
    _audioPlayer = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _record.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  // Button to start recording
  @override
  Widget build(BuildContext context) {
    return Consumer<PatientModelProvider>(
        builder: (context, patientModelProvider, child) {
      Patient patient = patientModelProvider.patient;
      return Container(
        padding: EdgeInsets.fromLTRB(20, 4, 20, 4),
        margin: EdgeInsets.fromLTRB(20, 0, 20, 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Take ${widget.take}"),
                    IconButton(
                      onPressed: isRecording ? stopRecording : startRecording,
                      icon: Icon(
                        isRecording
                            ? Icons.stop
                            : (!isRecording && audioPath.isNotEmpty)
                                ? Icons.check
                                : Icons.mic,
                      ),
                      color: isRecording
                          ? Colors.red
                          : (!isRecording && audioPath.isNotEmpty)
                              ? Colors
                                  .green // Change color to green when it's a tick
                              : Colors.blue,
                    ),
                    if (!isRecording && audioPath.isNotEmpty)
                      IconButton(
                        onPressed: () {
                          playRecording();
                        },
                        icon: Icon(Icons.play_arrow),
                      ),
                    // if (audioPath.isNotEmpty) Text("Audio Path: $audioPath"),
                  ],
                ),
                Row(
                  children: [
                    if (audioPath.isEmpty) Text("Record a sample"),
                    if (audioPath.isNotEmpty && result == "pending")
                      ElevatedButton(
                        onPressed: () async {
                          String localhost = Localhost.localhost;
                          String? response = await FileUploader.uploadFile(
                              audioPath, '$localhost:8000/upload');
                          patientModelProvider.addRecording(widget.vowel, response);
                          setState(() {
                            result = response;
                          });
                        },
                        child: Text('Analyze'),
                      ),
                    if (result != "pending" && result != "error")
                      if (result == "Healthy")
                        const Text(
                          "Healthy",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        )
                      else
                        Text(
                          result,
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        )
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Future<void> startRecording() async {
    try {
      if (await _record.hasPermission()) {
        await _record.start(
          encoder: AudioEncoder.wav,
        );
        setState(() {
          isRecording = true;
        });
        setState(() {
          isRecording = isRecording;
        });
      }
    } catch (e) {
      print("Error in startRecording: $e");
    }
  }

  Future<void> stopRecording() async {
    try {
      if (isRecording) {
        String? path = await _record.stop();
        setState(() {
          isRecording = false;
          audioPath = path!;
        });
        // Get the external storage directory using path_provider
        Directory? externalDirectory = await getExternalStorageDirectory();

        String? externalPath = externalDirectory?.path;

        // check if it exists, if not create it

        if (!await Directory('$externalPath/${widget.patientID}').exists()) {
          Directory('$externalPath/${widget.patientID}').createSync();
        }
        // create a folder for patientID and store the audio clip there

        // Move the audio file from its current location to the external storage directory
        String newFilePath =
            '$externalPath/${widget.patientID}/${widget.vowel}_take${widget.take}_audio.wav';
        await File(audioPath).copy(newFilePath);

        // Move the audio file from its current location to the external storage directory. and rename it to current vowel

        // String newFilePath = '$externalPath/${widget.vowel}_audio.wav';
        // await File(audioPath).copy(newFilePath);

        // Update audioPath with the new file path
        setState(() {
          audioPath = newFilePath;
          print("Audio Path: $audioPath");
        });
      }
    } catch (e) {
      print("Error in stopRecording: $e");
    }
  }

  Future<void> playRecording() async {
    try {
      Source urlSource = UrlSource(audioPath);
      await _audioPlayer.play(urlSource);
    } catch (e) {
      print("Error in playRecording: $e");
    }
  }

  Future<void> analyzeFile() async {
    String? response = await FileUploader.uploadFile(
        audioPath, 'http://192.168.8.134:8000/upload');
    setState(() {
      result = response;
    });
  }
}
