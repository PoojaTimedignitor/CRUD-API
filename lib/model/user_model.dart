
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool success;
  String message;
  int currentPage;
  int totalUsers;
  int totalPages;
  List<User> users;

  UserModel({
    required this.success,
    required this.message,
    required this.currentPage,
    required this.totalUsers,
    required this.totalPages,
    required this.users,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
  String phone;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phone": phone,
  };
}
