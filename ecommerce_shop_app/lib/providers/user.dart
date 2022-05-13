import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../api/api_url.dart';
import '../api/http_client.dart';

class User {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final DateTime birthDay;
  final String email;
  final String phoneNumber;
  final String address;
  final String avatar;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.birthDay,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.avatar,
  });

  factory User.fromJson(dynamic json) {
    return User(
        id: json["id"],
        username: json["username"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        birthDay: DateTime.parse(json["dob"]),
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        avatar: json["avatar"]);
  }
}

class UserMethod {
  Future<User> getUser() async {
    const storage = FlutterSecureStorage();
    final userJson = await storage.read(key: 'user');
    final user = json.decode(userJson!);
    final username = user["unique_name"];

    final url = Uri.parse('${ApiUrls.baseUrl}/api/Users/$username');
    try {
      final response = await HttpClient().get(url);
      // print(response.body);
      var userObj = json.decode(response.body);
      var user = User.fromJson(userObj);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editProfile(data) async {
    final url = Uri.parse('${ApiUrls.baseUrl}/api/Users/update');
    try {
      final response = await HttpClient().post(url);
    } catch (e) {
      rethrow;
    }
  }
}
