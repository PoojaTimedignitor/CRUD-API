

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  bool success;
  String message;
  UserProfile user;

  ProfileModel({
    required this.success,
    required this.message,
    required this.user,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    success: json["success"],
    message: json["message"],
    user: UserProfile.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "user": user.toJson(),
  };
}

class UserProfile {
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String profileImage;

  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.profileImage,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phone: json["phone"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phone": phone,
    "profileImage": profileImage,
  };
}
