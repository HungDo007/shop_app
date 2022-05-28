import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../api/http_client.dart';
import '../api/api_url.dart';
import '../utils/handle.dart';
import '../utils/http_exception.dart';

class UserInfo {
  String email = '';
  String username = '';
}

class Auth with ChangeNotifier {
  String _jwtToken = '';
  final _user = UserInfo();

  bool get isAuthenticate {
    return _jwtToken.isNotEmpty;
  }

  String get jwtToken {
    if (_jwtToken.isNotEmpty) {
      return _jwtToken;
    }
    return "";
  }

  UserInfo get userInfo {
    if (_jwtToken.isNotEmpty) {
      var user = Handle.parseJwt(_jwtToken);
      _user.email = user['email'];
      _user.username = user['unique_name'];
    }
    return _user;
  }

  Future<void> signIn(String username, String password) async {
    final url = Uri.parse('${ApiUrls.baseUrl}/api/Users/authenticate');
    try {
      final response = await HttpClient().post(
        url,
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );
      if (response.statusCode >= 400) {
        throw HttpException(response.body);
      }
      _jwtToken = response.body;
      final user = Handle.parseJwt(_jwtToken);
      const storage = FlutterSecureStorage();
      await storage.write(key: 'jwtToken', value: _jwtToken);
      await storage.write(key: 'user', value: json.encode(user));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String username, String email, String password) async {
    final url = Uri.parse('${ApiUrls.baseUrl}/api/Users/register');
    try {
      final response = await HttpClient().post(url,
          body: json.encode({
            'userName': username,
            'email': email,
            'password': password,
          }));
      if (response.statusCode >= 400) {
        final responseData = json.decode(response.body) as List;
        var responseStr = responseData.cast<String>();
        throw HttpException(responseStr.join('-'));
      }
      // notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void signOut() {
    _jwtToken = '';
    _user.email = '';
    _user.username = '';
    const storage = FlutterSecureStorage();
    storage.deleteAll();
    notifyListeners();
  }
}
