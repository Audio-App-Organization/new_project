import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../../models/PatientModel.dart';
import '../../models/PatientModelProvider.dart';
import 'PdfCreatorEngine.dart';
import 'RecordModel.dart';

class RecordPdfPreview extends StatelessWidget {

  final Map<String, List<String>> records;
  final String comment;

  const RecordPdfPreview({Key? key, required this.records, required this.comment}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<PatientModelProvider>(
        builder: (context, patientModelProvider, child) {
          return Scaffold(appBar: AppBar(title: Text('PDF Preview'),),
            body: PdfPreview(
              build: (context) => generatePdf(records, comment),),);
        });
  }
}
