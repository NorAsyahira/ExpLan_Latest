// To parse this JSON data, do
//
//     final personalDataModel = personalDataModelFromJson(jsonString);

import 'dart:convert';

List<PersonalDataModel> personalDataModelFromJson(String str) =>
    List<PersonalDataModel>.from(
        json.decode(str).map((x) => PersonalDataModel.fromJson(x)));

String personalDataModelToJson(List<PersonalDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PersonalDataModel {
  PersonalDataModel({
    this.id,
    this.username,
    this.birthday,
    this.gender,
    this.course,
    this.university,
    this.email,
  });

  int? id;
  String? username;
  DateTime? birthday;
  String? gender;
  String? course;
  String? university;
  dynamic email;

  factory PersonalDataModel.fromJson(Map<String, dynamic> json) =>
      PersonalDataModel(
        id: json["id"],
        username: json["username"],
        birthday: json["birthday"],
        gender: json["gender"],
        course: json["course"],
        university: json["university"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "birthday": birthday,
        "gender": gender,
        "course": course,
        "university": university,
        "email": email,
      };
}
