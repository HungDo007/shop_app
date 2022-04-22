import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpClient extends http.BaseClient {
  http.Client _httpClient = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final url = Uri.parse(
        "https://shop-app-58d69-default-rtdb.asia-southeast1.firebasedatabase.app/products.json");
    
    return _httpClient.send(request);

  }
}
