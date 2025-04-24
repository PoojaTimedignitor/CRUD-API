

import 'dart:convert';

DetailUserModel detailUserModelFromJson(String str) => DetailUserModel.fromJson(json.decode(str));

String detailUserModelToJson(DetailUserModel data) => json.encode(data.toJson());

class DetailUserModel {
  bool success;
  String message;
  int currentPage;
  int totalUsers;
  int totalPages;
  List<User> users;

  DetailUserModel({
    required this.success,
    required this.message,
    required this.currentPage,
    required this.totalUsers,
    required this.totalPages,
    required this.users,
  });

  factory DetailUserModel.fromJson(Map<String, dynamic> json) => DetailUserModel(
    success: json["success"],
    message: json["message"],
    currentPage: json["currentPage"],
    totalUsers: json["totalUsers"],
    totalPages: json["totalPages"],
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "currentPage": currentPage,
    "totalUsers": totalUsers,
    "totalPages": totalPages,
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
  };
}

class User {
  String id;
  String firstName;
  String lastName;
  String email;


  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
  };
}
