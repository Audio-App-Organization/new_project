import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class FileUploader {
  static Future<String> uploadFile(String filePath, String url) async {
    File file = File(filePath);

    if (!file.existsSync()) {
      print("File not found");
      return "404";
    }

    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      file.path,
    ));

    try {
      var StreamedResponse = await request.send();
      var response = await http.Response.fromStream(StreamedResponse);
      if (response.statusCode == 200) {
        print('Uploaded!');
        // Assuming response is in JSON format
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        String binaryPrediction = jsonResponse['binary_prediction'];
        int multiClassPrediction = jsonResponse['multi_class_prediction'];

        if (binaryPrediction == 'Healthy') {
          print('\nHealthy');
          return 'Healthy';

        } else {
          String diseaseName = getDiseaseNameFromPrediction(multiClassPrediction);
          print('\nDisease: $diseaseName');
          return diseaseName;
        }
      } else {
        print('Error! HTTP Status Code: ${response.statusCode}');
        return 'Error: HTTP Status Code ${response.statusCode}';
      }
    } catch (error) {
      print('Error: $error');
      return 'Error: $error';
    }
  }

  static String getDiseaseNameFromPrediction(int prediction) {
    // Add your logic to map prediction to disease names here
    // For example:
    if (prediction == 1) {
      return 'Disease A';
    } else if (prediction == 2) {
      return 'Disease B';
    } else {
      return 'Unknown Disease';
    }
  }
}
