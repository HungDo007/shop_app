import 'package:flutter/material.dart';

import '../widgets/order/order_item.dart';

class UserOrderPage extends StatelessWidget {
  const UserOrderPage({Key? key}) : super(key: key);

  static const routeName = "/user-order";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("My Purchases")),
        body: OrderItem(),
      ),
    );
  }
}

