// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  AuthModel({
    required this.success,
  });

  Success success;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    success: Success.fromJson(json["success"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success.toJson(),
  };
}

class Success {
  Success({
    required this.token,
    required this.id,
  });

  String token;
  int id;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
    token: json["token"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "id": id,
  };
}
