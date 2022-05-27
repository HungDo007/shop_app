import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../api/http_client.dart';
import '../api/api_url.dart';

class Category {
  final int id;
  final String name;
  final String image;
  
  final List parent;
  final bool isShowAtHome;

  Category(this.id, this.name, this.image, this.parent,
      this.isShowAtHome,);

  // factory Category.fromMap(Map<String, dynamic> json) {
  //   return Category(
  //     json["id"],
  //     json["name"],
  //     json["imageUrl"],
  //     json["status"],
  //   );
  // }

  //factory Category.fromJson(Map<String,>)
}

class Categories with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categoryItems {
    return [..._categories];
  }

  Future<void> fetchAndSetCategories() async {
    final url = Uri.parse('${ApiUrls.baseUrl}/api/Catalogs/category');
    try {
      // final response = await http.get(url);
      final response = await HttpClient().get(url);
      var categoryList = json.decode(response.body) as List;
      //final List<Category> loadedCategory = list.cast<Category>();
    _categories = categoryList.map((item) {
        return Category(
          item["id"],
          item["name"],
          item["image"],
          item["parent"],
          item["isShowAtHome"],
        );
      }).toList();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
