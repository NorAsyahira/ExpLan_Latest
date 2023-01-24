// To parse this JSON data, do
//
//     final timetableModel = timetableModelFromJson(jsonString);

import 'dart:convert';

List<TimetableModel> timetableModelFromJson(String str) => List<TimetableModel>.from(json.decode(str).map((x) => TimetableModel.fromJson(x)));

String timetableModelToJson(List<TimetableModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimetableModel {
    TimetableModel({
        required this.timetableId,
        required this.subjectCode,
        required this.day,
        required this.group,
        required this.startTime,
        required this.endTime,
        required this.location,
        required this.userId,
    });

    int timetableId;
    String subjectCode;
    String day;
    String group;
    String startTime;
    String endTime;
    String location;
    int? userId;

    factory TimetableModel.fromJson(Map<String, dynamic> json) => TimetableModel(
        timetableId: json["timetable_id"],
        subjectCode: json["subject_code"],
        day: json["day"],
        group: json["group"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        location: json["location"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "timetable_id": timetableId,
        "subject_code": subjectCode,
        "day": day,
        "group": group,
        "start_time": startTime,
        "end_time": endTime,
        "location": location,
        "user_id": userId,
    };
}

