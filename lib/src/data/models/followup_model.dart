import 'dart:convert';

FollowupModel followupModelFromJson(String str) =>
    FollowupModel.fromJson(json.decode(str));

String followupModelToJson(FollowupModel data) => json.encode(data.toJson());

class FollowupModel {
  String name;
  int phone;
  String property;
  bool reminder;
  DateTime? reminderDate;
  bool completed;

  FollowupModel({
    required this.name,
    required this.phone,
    required this.property,
    required this.reminder,
    required this.reminderDate,
    required this.completed,
  });

  factory FollowupModel.fromJson(Map<String, dynamic> json) => FollowupModel(
        name: json["name"] ?? "", // Default to empty string if null
        phone: json["phone"] ?? 0,
        property: json["property"] ?? "", // Default to empty string if null
        reminder: json["reminder"] ?? false, // Default to false if null
        reminderDate: json["reminderDate"] != null
            ? DateTime.parse(json["reminderDate"])
            : null,
        completed: json["completed"] ?? false, // Default to false if null
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "property": property,
        "reminder": reminder,
        if (reminderDate != null)
          "reminderDate": reminderDate?.toIso8601String(),
        "completed": completed,
      };
}
