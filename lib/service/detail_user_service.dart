import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/detail_user_model.dart';
import '../model/profile_model.dart';

class DetailUserService{
   final String baseUrl = 'https://testrepo-ahqn.onrender.com/api/users';


   Future<DetailUserModel?> getDetailUserData({int page = 1, int limit = 10}) async {
     final Uri url = Uri.parse("$baseUrl?page=$page&limit=$limit");
    try{
      final response = await http.get(url);
      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        return DetailUserModel.fromJson(json);
      }else{
        throw Exception('Failed to load Data : ${response.statusCode}');
        return null;
      }
    }catch(e){
      print("Error occurred while fetching users: $e");
       return null;
    }
   }


   Future<UserProfile?> getUserById(String id) async {
    // final response = await http.get(Uri.parse('https://testrepo-ahqn.onrender.com/api/users/$id'));
     final url = Uri.parse('https://testrepo-ahqn.onrender.com/api/users/$id');
     final response  = await http.get(url);
     if (response.statusCode == 200) {
       final jsonData = json.decode(response.body);
       final profile = ProfileModel.fromJson(jsonData);
       return profile.user;
     } else {
       return null;
     }
   }


   Future<bool> deleteUser(String id) async {
    // final response = await http.delete(Uri.parse('https://testrepo-ahqn.onrender.com/api/users/$id'));
     final url = Uri.parse('https://testrepo-ahqn.onrender.com/api/users/$id');
     final response  = await http.delete(url);
     if (response.statusCode == 200) {
       return true;
     } else {
       return false;
     }
   }


   Future<bool> updateUser(UserProfile user) async {
     final url = Uri.parse("https://testrepo-ahqn.onrender.com/api/users/${user.id}");
     final response = await http.put(
       url,
       headers: {'Content-Type': 'application/json'},
       body: jsonEncode({
         "firstName": user.firstName,
         "lastName": user.lastName,
         "email": user.email,
         "phone": user.phone,
       }),
     );
     return response.statusCode == 200;
   }

}
