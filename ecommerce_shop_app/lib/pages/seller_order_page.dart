import 'package:flutter/material.dart';

import '../providers/order.dart';
import '../widgets/order/order_item.dart';

class SellerOrderPage extends StatelessWidget {
  const SellerOrderPage({Key? key}) : super(key: key);

  static const routeName = "/seller-order";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("My Sales")),
        body: OrderItem(orderStatus: OrderStatus.inProgress,),
      ),
    );
  }
}

