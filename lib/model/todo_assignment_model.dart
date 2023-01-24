// To parse this JSON data, do
//
//     final todoAssignmentModel = todoAssignmentModelFromJson(jsonString);

import 'dart:convert';

List<TodoAssignmentModel> todoAssignmentModelFromJson(String str) =>
    List<TodoAssignmentModel>.from(
        json.decode(str).map((x) => TodoAssignmentModel.fromJson(x)));

String todoAssignmentModelToJson(List<TodoAssignmentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoAssignmentModel {
  TodoAssignmentModel({
    required this.id,
    required this.todoName,
  });

  int id;
  String todoName;

  factory TodoAssignmentModel.fromJson(Map<String, dynamic> json) =>
      TodoAssignmentModel(
        id: json["id"],
        todoName: json["todo_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "todo_name": todoName,
      };
}
