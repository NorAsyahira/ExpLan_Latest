// To parse this JSON data, do
//
//     final activityModel = activityModelFromJson(jsonString);

import 'dart:convert';

List<ActivityModel> activityModelFromJson(String str) =>
    List<ActivityModel>.from(
        json.decode(str).map((x) => ActivityModel.fromJson(x)));

String activityModelToJson(List<ActivityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityModel {
  ActivityModel({
    required this.activityId,
    required this.activityName,
    required this.hour,
    required this.activityType,
    required this.frequencyRate,
    required this.userId,
  });

  int activityId;
  String activityName;
  String hour;
  String activityType;
  String frequencyRate;
  int? userId;

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        activityId: json["activity_id"],
        activityName: json["activity_name"],
        hour: json["hour"],
        activityType: json["activity_type"],
        frequencyRate: json["frequency_rate"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "activity_id": activityId,
        "activity_name": activityName,
        "hour": hour,
        "activity_type": activityType,
        "frequency_rate": frequencyRate,
        "userId": userId,
      };
}
