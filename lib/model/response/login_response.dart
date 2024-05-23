// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool? success;
  String? token;
  User? user;
  String? message;

  LoginResponse({
    this.success,
    this.token,
    this.user,
    this.message
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"] ?? "Unable to login",
    token: json["token"],
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "token": token,
    "message": message,
    "user": user?.toJson(),
  };
}

class User {
  String? id;
  bool? isSuspended;
  String? userType;
  String? email;
  String? fullname;
  String? contact;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? uuid;

  User({
    this.id,
    this.isSuspended,
    this.userType,
    this.email,
    this.fullname,
    this.contact,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.uuid,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    isSuspended: json["isSuspended"],
    userType: json["userType"],
    email: json["email"],
    fullname: json["fullname"],
    contact: json["contact"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    uuid: json["uuid"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isSuspended": isSuspended,
    "userType": userType,
    "email": email,
    "fullname": fullname,
    "contact": contact,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "uuid": uuid,
  };
}
