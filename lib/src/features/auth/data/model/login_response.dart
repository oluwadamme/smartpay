// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final User? user;
  final String? token;

  LoginResponse({
    this.user,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };
}

class User {
  final String? id;
  final String? fullName;
  final String? username;
  final String? email;
  final dynamic phone;
  final dynamic phoneCountry;
  final String? country;
  final dynamic avatar;

  User({
    this.id,
    this.fullName,
    this.username,
    this.email,
    this.phone,
    this.phoneCountry,
    this.country,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        phoneCountry: json["phone_country"],
        country: json["country"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "username": username,
        "email": email,
        "phone": phone,
        "phone_country": phoneCountry,
        "country": country,
        "avatar": avatar,
      };
}
