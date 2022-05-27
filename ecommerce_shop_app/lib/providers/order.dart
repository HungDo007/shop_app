import 'dart:convert';

import '../api/api_url.dart';
import '../api/http_client.dart';

enum OrderStatus {
  inProgress,
  confirmed,
  shipping,
  success,
  canceled,
  getAll,
}

class OrderArguments {
  final int orderId;
  final String name;
  final String phoneNumber;
  final String address;
  final int orderStatus;

  OrderArguments(this.orderId, this.name, this.phoneNumber, this.address,
      this.orderStatus);
}

class Order {
  final int id;
  final String name;
  final int orderStatus;
  final bool paid;
  final int quantity;
  final String seller;
  final String shipName;
  final String shipPhone;
  final String shipAddress;
  final String shopName;
  final num sumPrice;

  Order(
    this.id,
    this.name,
    this.orderStatus,
    this.paid,
    this.quantity,
    this.seller,
    this.shipName,
    this.shipPhone,
    this.shipAddress,
    this.shopName,
    this.sumPrice,
  );

  factory Order.fromJson(dynamic json) {
    return Order(
      json["id"],
      json["name"],
      json["orderStatus"],
      json["paid"],
      json["quantity"],
      json["seller"],
      json["shipName"],
      json["shipPhonenumber"],
      json["shipAddress"],
      json["shopName"] ?? json["seller"],
      json["sumPrice"],
    );
  }
}

class OrderDetail {
  final String details;
  final String name;
  final num price;
  final int productDetailId;
  final String productImg;
  final int quantity;

  OrderDetail(
    this.details,
    this.name,
    this.price,
    this.productDetailId,
    this.productImg,
    this.quantity,
  );

  factory OrderDetail.fromJson(dynamic json) {
    return OrderDetail(
      json["details"],
      json["name"],
      json["price"],
      json["productDetailId"],
      json["productImg"],
      json["quantity"],
    );
  }
}

class Orders {
  String getOrderStatus(int status) {
    switch (status) {
      case 0:
        return "In Progress";
      case 1:
        return "Confirmed";
      case 2:
        return "Shipping";
      case 3:
        return "Success";
      case 4:
        return "Cancelled";
      default:
        return "Get All";
    }
  }

  Future<void> order(data) async {
    final url = Uri.parse('${ApiUrls.baseUrl}/api/Sales/Order');
    try {
      await HttpClient().post(url, body: json.encode(data));
    } catch (e) {
      rethrow;
    }
  }

  Future<String> orderPayPal(data) async {
    final url = Uri.parse('${ApiUrls.baseUrl}/api/Sales/PaymentOrder');
    try {
      final response = await HttpClient().post(url, body: json.encode(data));
      final paymentUrl = json.decode(response.body) as String;
      return paymentUrl;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Order>> getAllOrder() async {
    final url =
        Uri.parse('${ApiUrls.baseUrl}/api/Sales/OrderAllOfUser?PageSize=100');
    try {
      final response = await HttpClient().get(url);
      final orderPaging = json.decode(response.body);
      final items = orderPaging["items"] as List;
      final orderList = items.map((order) {
        return Order.fromJson(order);
      }).toList();
      return orderList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Order>> getOrder(int orderStatus) async {
    final url = Uri.parse(
        '${ApiUrls.baseUrl}/api/Sales/User/Order/$orderStatus?PageSize=100');
    try {
      final response = await HttpClient().get(url);
      final orderPaging = json.decode(response.body);
      final items = orderPaging["items"] as List;
      final orderList = items.map((order) {
        return Order.fromJson(order);
      }).toList();
      return orderList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrderDetail>> getOrderDetail(int orderId) async {
    final url = Uri.parse('${ApiUrls.baseUrl}/api/Sales/Order/$orderId');
    try {
      final response = await HttpClient().get(url);
      final orderDetails = json.decode(response.body) as List;
      final orderDetailList = orderDetails.map((order) {
        return OrderDetail.fromJson(order);
      }).toList();
      return orderDetailList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cancelOrder(int orderId) async {
    final url = Uri.parse('${ApiUrls.baseUrl}/api/Sales/Order/$orderId');
    try {
      await HttpClient().delete(url);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> checkoutStatus(data) async {
    final url = Uri.parse('${ApiUrls.baseUrl}/api/Sales/CheckoutStatus');
    try {
      await HttpClient().post(url, body: json.encode(data));
    } catch (e) {
      rethrow;
    }
  }
}
