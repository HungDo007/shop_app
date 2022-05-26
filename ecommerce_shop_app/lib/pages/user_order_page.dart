import 'package:flutter/material.dart';

import '../providers/order.dart';
import '../widgets/order/order_item.dart';

class UserOrderPage extends StatelessWidget {
  const UserOrderPage({Key? key}) : super(key: key);

  static const routeName = "/user-order";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: const Text("My Purchases"),
              bottom: const TabBar(
                isScrollable: true,
                labelColor: Colors.white,
                tabs: [
                  Tab(
                    child: Text("All"),
                  ),
                  Tab(
                    child: Text("In Progress"),
                  ),
                  Tab(
                    child: Text("Confirmed"),
                  ),
                  Tab(
                    child: Text("Cancelled"),
                  ),
                ],
              )),
          body: const TabBarView(children: [
            OrderItem(
              orderStatus: OrderStatus.getAll,
            ),
            OrderItem(
              orderStatus: OrderStatus.inProgress,
            ),
            OrderItem(
              orderStatus: OrderStatus.confirmed,
            ),
            OrderItem(
              orderStatus: OrderStatus.canceled,
            ),
          ]),
        ),
      ),
    );
  }
}
