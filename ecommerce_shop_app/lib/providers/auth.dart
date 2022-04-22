import 'dart:convert';

import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;

import '../api/api_url.dart';
import '../utils/http_exception.dart';

class Auth with ChangeNotifier {
  String _jwtToken = "";

  bool get isAuthenticate {
    return _jwtToken.isNotEmpty;
  }

  String get jwtToken {
    if (_jwtToken.isNotEmpty) {
      return _jwtToken;
    }
    return "";
  }

  Future<void> signIn(String username, String password) async {
    final url = Uri.parse('${ApiUrls.baseUrl}/api/Users/authenticate');
    try {
      final response = await http.post(url,
          body: json.encode({
            "username": username,
            "password": password,
          }),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });
      _jwtToken = response.body;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String username, String email, String password) async {
    final url = Uri.parse('${ApiUrls.baseUrl}/api/Users/register');
    try {
      final response = await http.post(url,
          body: json.encode({
            "userName": username,
            "email": email,
            "password": password,
          }),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });
      if (response.statusCode >= 400) {
        final responseData = json.decode(response.body) as List;
        var responseStr = responseData.cast<String>();
        throw HttpException(responseStr.join("-"));
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
