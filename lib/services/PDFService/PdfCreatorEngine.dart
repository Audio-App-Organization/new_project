import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'RecordModel.dart';

Future<Uint8List> generatePdf(
    Map<String, List<String>> records, String comment) async {
  final pdf = Document();
  int index = 0;


  pdf.addPage(
    MultiPage(
      build: (context) => <Widget>[
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Patient Report",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text("Date: 12/12/2021", style: TextStyle(fontSize: 12)),
                    // Patient Name
                    SizedBox(height: 5),
                    Text("Patient Name: John Doe",
                        style: TextStyle(fontSize: 12)),
                    // Patient Age
                    SizedBox(height: 5),
                    //Therapist Name
                    Text("Therapist Name: John Doe",
                        style: TextStyle(fontSize: 12)),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ],
            ),
            Container(height: 50),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Vowel',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  flex: 1,
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'Take 01',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  flex: 1,
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'Take 02',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  flex: 1,
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'Take 03',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  flex: 1,
                ),
              ],
            ),
            // print each map key and value
            for (var entry in records.entries)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      entry.key,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    flex: 1,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      entry.value[0],
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    flex: 1,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      entry.value[1],
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    flex: 1,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      entry.value[2],
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    flex: 1,
                  ),
                ],
              ),
            Container(height: 50),
            Text(
              'Comment',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              comment,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        )
      ],
    ),
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
