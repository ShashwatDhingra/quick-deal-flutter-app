// To parse this JSON data, do
//
//     final leadModel = leadModelFromJson(jsonString);

import 'dart:convert';

LeadModel leadModelFromJson(String str) => LeadModel.fromJson(json.decode(str));

String leadModelToJson(LeadModel data) => json.encode(data.toJson());

class LeadModel {
  String id;
  String name;
  int phone;
  String email;
  String assigned;
  String propertytype;
  String leadstatus;
  String status;
  String remarks;

  LeadModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.assigned,
    required this.propertytype,
    required this.leadstatus,
    required this.status,
    required this.remarks,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) => LeadModel(
        id: json["_id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        assigned: json["assigned"] ?? "",
        propertytype: json["propertytype"],
        leadstatus: json["leadstatus"],
        status: json["status"],
        remarks: json["remarks"]??"",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "assigned": assigned,
        "propertytype": propertytype,
        "leadstatus": leadstatus,
        "status": status,
        "remarks": remarks,
      };
}
