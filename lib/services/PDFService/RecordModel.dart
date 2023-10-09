import 'dart:convert';

List<RecordModel> recordModelFromJson(String str) => List<RecordModel>.from(
    json.decode(str).map((x) => RecordModel.fromJson(x)));

String recordModelToJson(List<RecordModel> data) => json.encode(
    List<dynamic>.from(data.map((x) => x.toJson())));

class RecordModel {
  RecordModel({
    required this.vowel,
    required this.take01,
    required this.take02,
    required this.take03,
  });

  String vowel;
  String take01;
  String take02;
  String take03;

  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
        vowel: json["vowel"],
        take01: json["take01"],
        take02: json["take02"],
        take03: json["take03"],
      );

  Map<String, dynamic> toJson() => {
        "vowel": vowel,
        "take01": take01,
        "take02": take02,
        "take03": take03,
      };
}
