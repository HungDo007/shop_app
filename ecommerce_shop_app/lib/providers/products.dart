import 'dart:convert';

import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;
import '../api/api_url.dart';

class Product {
  final int id;
  final String seller;
  final String name;
  final String description;
  final int categoryId;
  final int viewCount;
  final int rate;
  final int status;
  final double price;
  final DateTime dateCreated;
  final String poster;
  final List<String> images;
  final List<ProductDetail> productDetails;

  Product({
    required this.id,
    required this.seller,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.viewCount,
    required this.rate,
    required this.status,
    required this.price,
    required this.dateCreated,
    required this.poster,
    required this.images,
    required this.productDetails,
  });
}

class ProductDetail {
  final int id;
  final int stock;
  final double price;
  final List componentDetails;

  ProductDetail(this.id, this.stock, this.price, this.componentDetails);
}

class Products with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get productItems {
    return [..._products];
  }

  Future<void> fetchAndSetProducts() async {
    final url =
        Uri.parse('${ApiUrls.baseUrl}/api/Catalogs/product?PageSize=100');
    try {
      final response = await http.get(url);
      //final List<Category> loadedCategory = list.cast<Category>();
      final productPaging = json.decode(response.body);
      // _products = productPaging["items"]
      //print(productPaging["items"]);
      var items = productPaging["items"] as List;
      var productList = items.map((item) {
        var listImage = item["images"] as List;
        var listProductDetail = item["productDetails"] as List;
        return Product(
          id: item["id"],
          seller: item["seller"],
          name: item["name"],
          description: item["description"],
          categoryId: item["category"],
          viewCount: item["viewCount"],
          rate: item["rate"],
          status: item["status"],
          price: item["price"],
          dateCreated: DateTime.parse(item["dateCreated"]),
          poster: item["poster"],
          images: listImage.cast<String>(),
          productDetails: listProductDetail.map((e) {
            return ProductDetail(
              e["id"],
              e["stock"],
              e["price"],
              e["componentDetails"],
            );
          }).toList(),
        );
      }).toList();
      _products = productList;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
