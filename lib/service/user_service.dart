
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class UserService {
  final String baseUrl = "https://testrepo-ahqn.onrender.com/api/users";

  Future<UserModel?> getUsersData({int page = 1, int limit = 10}) async {
    final Uri url = Uri.parse("$baseUrl?page=$page&limit=$limit");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return UserModel.fromJson(jsonData);
      } else {
        print("Failed to load users: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred while fetching users: $e");
      return null;
    }
  }
}

