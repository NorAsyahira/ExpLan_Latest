// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

List<CourseModel> courseModelFromJson(String str) => List<CourseModel>.from(json.decode(str).map((x) => CourseModel.fromJson(x)));

String courseModelToJson(List<CourseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseModel {
    CourseModel({
        required this.courseCode,
        required this.courseName,
    });

    String? courseCode;
    String? courseName;

    factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        courseCode: json["course_code"],
        courseName: json["course_name"],
    );

    Map<String, dynamic> toJson() => {
        "course_code": courseCode,
        "course_name": courseName,
    };
}
