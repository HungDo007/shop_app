import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../api/http_client.dart';
// import "package:http/http.dart" as http;

import '../api/api_url.dart';

class Cart {
  final String shopName;
  final int cartId;
  final int productId;
  final String name;
  final String details;
  final String productImg;
  final int quantity;
  final double price;
  final int stockOfDetail;

  Cart({
    required this.shopName,
    required this.cartId,
    required this.productId,
    required this.name,
    required this.details,
    required this.productImg,
    required this.quantity,
    required this.price,
    required this.stockOfDetail,
  });

  factory Cart.fromJson(dynamic json) {
    return Cart(
      shopName: json["shopName"],
      cartId: json["cartId"],
      productId: json["productId"],
      name: json["name"],
      details: json["details"],
      productImg: json["productImg"],
      quantity: json["quantity"],
      price: json["price"],
      stockOfDetail: json["stockOfDetail"],
    );
  }
}

class Carts with ChangeNotifier {
  List<Cart> cartItems = [];

  int get itemCount {
    return cartItems.isEmpty ? 0 : cartItems.length;
  }

  double get totalAmount {
    var total = 0.0;
    for (var cartItem in cartItems) {
      total += cartItem.price * cartItem.quantity;
    }
    return total;
  }

  Future<void> addToCart(int productDetailId, int amount) async {
    final url = Uri.parse('${ApiUrls.baseUrl}/api/Sales/AddCart');
    try {
      await HttpClient().post(url,
          body: json.encode({
            "productDetailId": productDetailId,
            "quantity": amount,
          }));
      await getCart();
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Cart>> getCart() async {
    final url = Uri.parse('${ApiUrls.baseUrl}/api/Sales/cart?PageSize=100');
    try {
      final response = await HttpClient().get(url);
      final cartPaging = json.decode(response.body);
      final items = cartPaging["items"] as List;

      final cartList = items.map((cart) {
        return Cart.fromJson(cart);
      }).toList();

      cartItems = cartList;
      // print(itemCount);
      notifyListeners();
      return cartList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeCartItem(List<int> cartItems) async {
    final url = Uri.parse('${ApiUrls.baseUrl}/api/Sales/removeCart');
    try {
      await HttpClient().post(url, body: json.encode(cartItems));
      await getCart();
    } catch (e) {
      rethrow;
    }
  }
}