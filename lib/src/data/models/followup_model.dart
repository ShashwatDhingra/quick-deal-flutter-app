import 'dart:convert';

FollowupModel followupModelFromJson(String str) =>
    FollowupModel.fromJson(json.decode(str));

String followupModelToJson(FollowupModel data) => json.encode(data.toJson());

class FollowupModel {
  String followUpBy;
  String property;
  String comments;
  String priority;
  bool reminder;
  DateTime reminderDate;
  bool completed;

  FollowupModel({
    required this.followUpBy,
    required this.property,
    required this.comments,
    required this.priority,
    required this.reminder,
    required this.reminderDate,
    required this.completed,
  });

  factory FollowupModel.fromJson(Map<String, dynamic> json) => FollowupModel(
        followUpBy: json["followUpBy"] ?? "", // Default to empty string if null
        property: json["property"] ?? "", // Default to empty string if null
        comments: json["comments"] ?? "", // Default to empty string if null
        priority: json["priority"] ?? "medium", // Default to "medium" if null
        reminder: json["reminder"] ?? false, // Default to false if null
        reminderDate: json["reminderDate"] != null
            ? DateTime.parse(json["reminderDate"])
            : DateTime.now(), // Default to current date if null
        completed: json["completed"] ?? false, // Default to false if null
      );

  Map<String, dynamic> toJson() => {
        "followUpBy": followUpBy,
        "property": property,
        "comments": comments,
        "priority": priority,
        "reminder": reminder,
        "reminderDate": reminderDate.toIso8601String(),
        "completed": completed,
      };
}
