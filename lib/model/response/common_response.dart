// To parse this JSON data, do
//
//     final commonResponse = commonResponseFromJson(jsonString);

import 'dart:convert';

CommonResponse commonResponseFromJson(String str) => CommonResponse.fromJson(json.decode(str));

String commonResponseToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  CommonResponse({
    this.success,
    this.message,
  });

  bool ? success;
  String ? message;

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
      success: json["success"],
      message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message
  };
}
