// To parse this JSON data, do
//
//     final usersModel = usersModelFromJson(jsonString);

/*import 'dart:convert';

List<UsersModel> usersModelFromJson(String str) =>
    List<UsersModel>.from(json.decode(str).map((x) => UsersModel.fromJson(x)));

String usersModelToJson(List<UsersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersModel {
  UsersModel({
    required this.id,
    required this.username,
    required this.birthday,
    required this.gender,
    required this.course,
    required this.university,
    required this.email,
  });

  int id;
  String username;
  String birthday;
  String gender;
  String? course;
  String university;
  dynamic email;
  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
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
        "course": course == null ? null : course,
        "university": university,
        "email": email,
      };
}*/

// To parse this JSON data, do
//
//     final subjectModel = subjectModelFromJson(jsonString);

import 'dart:convert';

List<UsersModel> usersModelFromJson(String str) => List<UsersModel>.from(json.decode(str).map((x) => UsersModel.fromJson(x)));

String usersModelToJson(List<UsersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersModel {
    UsersModel({
        required this.personalDataId,
        required this.username,
        required this.birthday,
        required this.gender,
        required this.course,
        required this.university,
        required this.time,
        required this.timesADay,
        required this.timeWakeup,
        required this.timeSleep,
        required this.userId,
    });

    int personalDataId;
    String username;
    String birthday;
    String gender;
    String? course;
    String university;
    dynamic time;
    dynamic timesADay;
    dynamic timeWakeup;
    dynamic timeSleep;
    int userId;

    factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        personalDataId: json["personalDataId"],
        username: json["username"],
        birthday: json["birthday"],
        gender: json["gender"],
        course: json["course"],
        university: json["university"],
        time: json["time"],
        timesADay: json["times_a_day"],
        timeWakeup: json["time_wakeup"],
        timeSleep: json["time_sleep"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "personalDataId": personalDataId,
        "username": username,
        "birthday": birthday,
        "gender": gender,
        "course": course,
        "university": university,
        "time": time,
        "times_a_day": timesADay,
        "time_wakeup": timeWakeup,
        "time_sleep": timeSleep,
        "user_id": userId,
    };
}

