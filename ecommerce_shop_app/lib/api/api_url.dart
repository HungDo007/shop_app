import 'package:flutter/foundation.dart';

class ApiUrls {
  // static const String baseUrl = 'http://10.0.2.2:5000';
  static const String baseUrl = kIsWeb ? 'http://localhost:5000' : "http://10.0.2.2:5000";
}
