import 'package:flutter/material.dart';
import 'package:new_project/models/PatientModelProvider.dart';
import 'package:new_project/services/PDFService/RecordPdfPreview.dart';
import 'package:provider/provider.dart';

import '../services/PDFService/RecordModel.dart';

class CreatePDF extends StatefulWidget {
  @override
  _CreatePDFState createState() => _CreatePDFState();
}

class _CreatePDFState extends State<CreatePDF> {
  final TextEditingController _commentController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Consumer<PatientModelProvider>(
        builder: (context, patientModelProvider, child) {
      print("PDF Prcoess Started");

      print("Assigned to recordModel");
      return Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Therapist's Comments"),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.all(32),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Therapist Comment',
                    style: TextStyle(fontSize: 24),
                  ),
                  TextFormField(
                    controller: _commentController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: 'Enter a comment',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print("Create PDF Pressed");
                      // save the patient details
                      patientModelProvider.patient.comment =
                          _commentController.text;
                      patientModelProvider.updateDatabase();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          // builder: (context) => PdfPreviewPage(invoice: _userModel),),);

                          builder: (context) => RecordPdfPreview(
                              records: patientModelProvider.patient.recordings,
                              comment: _commentController.text),
                        ),
                      );
                    },
                    child: Text('Create'),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
