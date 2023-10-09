import 'dart:developer';

import 'package:http/http.dart' as http;

import 'RecordModel.dart';

class ApiService {
  Future<List<RecordModel>?> getPatientDetails() async {
    try {
      //http request
      var url = Uri.parse('localhost:3000/patient');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<RecordModel> _model = recordModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
