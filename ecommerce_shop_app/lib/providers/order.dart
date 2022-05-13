import 'dart:convert';

import '../api/api_url.dart';
import '../api/http_client.dart';

class Order{
  Future<void> order(data) async {
    final url = Uri.parse('${ApiUrls.baseUrl}/api/Sales/Order');
    try {
      final response = await HttpClient().post(url, body: json.encode(data));
      print(response.statusCode);
    } catch (e) {
      rethrow;
    }
  }
}