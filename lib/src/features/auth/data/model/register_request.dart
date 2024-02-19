// To parse this JSON data, do
//
//     final registerRequest = registerRequestFromJson(jsonString);

import 'dart:convert';

RegisterRequest registerRequestFromJson(String str) => RegisterRequest.fromJson(json.decode(str));

String registerRequestToJson(RegisterRequest data) => json.encode(data.toJson());

class RegisterRequest {
  String? fullName;
  String? username;
  String? email;
  String? password;
  String? country;
  String? deviceName;

  RegisterRequest({
    this.fullName,
    this.username,
    this.email,
    this.password,
    this.country,
    this.deviceName,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => RegisterRequest(
        fullName: json["full_name"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        country: json["country"],
        deviceName: json["device_name"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "username": username,
        "email": email,
        "password": password,
        "country": country,
        "device_name": deviceName,
      };
}
