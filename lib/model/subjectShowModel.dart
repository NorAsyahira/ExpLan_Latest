// To parse this JSON data, do
//
//     final studentShowModel = studentShowModelFromJson(jsonString);

import 'dart:convert';
import 'dart:html';

import 'package:time2study/widgets/date_picker.dart';

SubjectShowModel subjectShowModelFromJson(String str) =>
    SubjectShowModel.fromJson(json.decode(str));

String subjectShowModelToJson(SubjectShowModel data) =>
    json.encode(data.toJson());

class SubjectShowModel {
  SubjectShowModel({
    required this.id,
    required this.subject_name,
    required this.date,
    required this.start_time,
    required this.end_time,
    required this.description,
  });

  int id;
  String subject_name;
  DatePicker date;
  TimeRanges start_time;
  TimeRanges end_time;
  String description;

  factory SubjectShowModel.fromJson(Map<String, dynamic> json) =>
      SubjectShowModel(
        id: json["id"],
        subject_name: json["subject_name"],
        date: json["date"],
        start_time: json["start_time"],
        end_time: json["end_time"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject_name": subject_name,
        "date": date,
        "start_time": start_time,
        "end_time": end_time,
        "description": description,
      };
}