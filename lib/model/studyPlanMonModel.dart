// To parse this JSON data, do
//
//     final studyPlanMonModel = studyPlanMonModelFromJson(jsonString);

import 'dart:convert';

List<dynamic> studyPlanMonModelFromJson(String str) =>
    List<dynamic>.from(json.decode(str).map((x) => x));

String studyPlanMonModelToJson(List<dynamic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));

class StudyPlanMonModelElement {
  StudyPlanMonModelElement({
    required this.activityId,
    required this.activityName,
    required this.hour,
    required this.activityType,
    required this.frequencyRate,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.personalDataId,
    required this.username,
    required this.birthday,
    required this.gender,
    required this.course,
    required this.university,
    required this.studyHabbit,
    required this.studyTimeAWeek,
    required this.timeWakeup,
    required this.timeSleep,
  });

  String? activityId;
  String? activityName;
  String? hour;
  String? activityType;
  String? frequencyRate;
  String userId;
  String startTime;
  String endTime;
  String? personalDataId;
  String? username;
  String? birthday;
  String? gender;
  String? course;
  String? university;
  String? studyHabbit;
  String? studyTimeAWeek;
  String? timeWakeup;
  String? timeSleep;

  factory StudyPlanMonModelElement.fromJson(Map<String, dynamic> json) =>
      StudyPlanMonModelElement(
        activityId: json["activity_id"],
        activityName: json["activity_name"],
        hour: json["hour"],
        activityType: json["activity_type"],
        frequencyRate: json["frequency_rate"],
        userId: json["user_id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        personalDataId: json["personalData_id"],
        username: json["username"],
        birthday: json["birthday"],
        gender: json["gender"],
        course: json["course"],
        university: json["university"],
        studyHabbit: json["study_habbit"],
        studyTimeAWeek: json["study_time_a_week"],
        timeWakeup: json["time_wakeup"],
        timeSleep: json["time_sleep"],
      );

  Map<String, dynamic> toJson() => {
        "activity_id": activityId,
        "activity_name": activityName,
        "hour": hour,
        "activity_type": activityType,
        "frequency_rate": frequencyRate,
        "user_id": userId,
        "start_time": startTime,
        "end_time": endTime,
        "personalData_id": personalDataId,
        "username": username,
        "birthday": birthday,
        "gender": gender,
        "course": course,
        "university": university,
        "study_habbit": studyHabbit,
        "study_time_a_week": studyTimeAWeek,
        "time_wakeup": timeWakeup,
        "time_sleep": timeSleep,
      };
}

class PurpleStudyPlanMonModel {
  PurpleStudyPlanMonModel({
    required this.timetableId,
    required this.subjectCode,
    required this.day,
    required this.group,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.userId,
  });

  String timetableId;
  String? subjectCode;
  String day;
  String? group;
  String? startTime;
  String? endTime;
  String? location;
  String? userId;

  factory PurpleStudyPlanMonModel.fromJson(Map<String, dynamic> json) =>
      PurpleStudyPlanMonModel(
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
