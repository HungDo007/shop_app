import 'dart:convert';

import 'package:ecommerce_shop_app/data.dart';
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
  final num price;
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

  factory Product.fromJson(dynamic json) {
    final imageList = json["images"] as List;
    final productDetailList = json["productDetails"] as List;
    return Product(
      id: json["id"],
      seller: json["seller"],
      name: json["name"],
      description: json["description"],
      categoryId: json["category"],
      viewCount: json["viewCount"],
      rate: json["rate"],
      status: json["status"],
      price: json["price"],
      dateCreated: DateTime.parse(json["dateCreated"]),
      poster: json["poster"],
      images: imageList.cast<String>(),
      productDetails: productDetailList.map((productDetail) {
        final componentDetailList = productDetail["componentDetails"] as List;
        return ProductDetail(
          productDetail["id"],
          productDetail["stock"],
          productDetail["price"],
          componentDetailList.map((componentDetail) {
            return ComponentDetail(
              componentDetail["id"],
              componentDetail["compId"],
              componentDetail["name"],
              componentDetail["value"],
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}

class ProductDetail {
  final int id;
  final int stock;
  final double price;
  final List<ComponentDetail> componentDetails;

  ProductDetail(this.id, this.stock, this.price, this.componentDetails);
}

class ComponentDetail {
  final int id;
  final int comId;
  final String name;
  final String value;

  ComponentDetail(this.id, this.comId, this.name, this.value);
}

class Products with ChangeNotifier {
  // List<Product> _products = [];

  // List<Product> get productItems {
  //   return [..._products];
  // }

  Future<List<Product>> fetchAndSetProducts(
      int categoryId, String keyword) async {
    final url = Uri.parse(
        '${ApiUrls.baseUrl}/api/Catalogs/product?CatId=$categoryId&Keyword=$keyword&PageSize=100');

    try {
      // final response = await http.get(url);
      // final productPaging = json.decode(response.body);
      // final items = productPaging["items"] as List;

      // final productList = items.map((product) {
      //   return Product.fromJson(product);
      // }).toList();
      // return productList;

      //data from file
      var pro = Data.products;
      final product = pro.map((product) {
        return Product.fromJson(product);
      }).toList();
      return product;
    } catch (error) {
      rethrow;
    }
  }

  Future<Product> fetchProductDetail(int id) async {
    final url = Uri.parse('${ApiUrls.baseUrl}/api/Catalogs/product/$id');

    try {
      final response = await http.get(url);
      var pro = json.decode(response.body);
      // print(pro);
      final product = Product.fromJson(pro);
      return product;
    } catch (error) {
      rethrow;
    }
  }
}
