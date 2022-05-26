import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class HttpClient extends http.BaseClient {
  final _httpClient = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    const storage = FlutterSecureStorage();
    Map<String, String> defaultHeaders = {
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    final token = await storage.read(key: 'jwtToken');
    if (token != null) {
      defaultHeaders.addAll({'Authorization': 'Bearer ${json.decode(token)}'});
    }
    request.headers.addAll(defaultHeaders);
    return _httpClient.send(request);
  }

  
}
