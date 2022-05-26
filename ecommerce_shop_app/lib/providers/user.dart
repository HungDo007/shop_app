import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_shop_app/utils/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

import '../api/api_url.dart';
import '../api/http_client.dart';

class User {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String birthDay;
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
        birthDay: json["dob"],
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

  Future<void> editProfile(User user, String filepath) async {
    var url = Uri.parse('${ApiUrls.baseUrl}/api/Users/update');

    var request = http.MultipartRequest("POST", url);
    request.fields["username"] = user.username;
    request.fields["firstName"] = user.firstName;
    request.fields["lastName"] = user.lastName;
    request.fields["dob"] = user.birthDay;
    request.fields["phoneNumber"] = user.phoneNumber;
    request.fields["address"] = user.address;
    request.fields["email"] = user.email;

    if (filepath.isNotEmpty) {
      request.files.add(http.MultipartFile.fromBytes(
          "avatar", File(filepath).readAsBytesSync(),
          filename: filepath.split("/").last));
      // request.files.add(http.MultipartFile("avatar",
      //     File(filepath).readAsBytes().asStream(), File(filepath).lengthSync(),
      //     filename: filepath.split("/").last));
    }
    try {
      // var response = await request.send();
      var response = await HttpClient().send(request);

      print(response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePassword(data) async {
    var url = Uri.parse('${ApiUrls.baseUrl}/api/Users/ChangePassword');
    try {
      var response = await HttpClient().post(url, body: json.encode(data));
      if (response.statusCode == 400) {
        throw HttpException("Your password is incorrect");
      }
    } catch (e) {
      rethrow;
  }
  }
}
