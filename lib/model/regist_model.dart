// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegistModel registerModelFromJson(String str) =>
    RegistModel.fromJson(json.decode(str));

String registerModelToJson(RegistModel data) => json.encode(data.toJson());

class RegistModel {
  bool status;
  String message;

  RegistModel({required this.status, required this.message});

  factory RegistModel.fromJson(Map<String, dynamic> json) =>
      RegistModel(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}
