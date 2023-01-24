// To parse this JSON data, do
//
//     final subjectModel = subjectModelFromJson(jsonString);

import 'dart:convert';

List<SubjectModel> subjectModelFromJson(String str) => List<SubjectModel>.from(json.decode(str).map((x) => SubjectModel.fromJson(x)));

String subjectModelToJson(List<SubjectModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubjectModel {
    SubjectModel({
        required this.subjectCode,
        required this.subjectName,
    });

    String? subjectCode;
    String? subjectName;

    factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        subjectCode: json["subject_code"],
        subjectName: json["subject_name"],
    );

    Map<String, dynamic> toJson() => {
        "subject_code": subjectCode,
        "subject_name": subjectName,
    };
}
