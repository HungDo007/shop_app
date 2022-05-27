import 'package:flutter/material.dart';

import '../../pages/order_detail_page.dart';
import '../../providers/order.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key? key,
    required this.orderStatus,
  }) : super(key: key);

  final OrderStatus orderStatus;

  Future<List<Order>> _handleOrderFuture() {
    switch (orderStatus) {
      case OrderStatus.getAll:
        return Orders().getAllOrder();
      default:
        return Orders().getOrder(orderStatus.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _handleOrderFuture(),
      builder: (ctx, orderSnapshot) {
        if (orderSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (orderSnapshot.hasError) {
            // print(orderSnapshot.error);
            return const Center(
              child: Text("Sorry, something went wrong!"),
            );
          } else {
            var orderList = orderSnapshot.data as List<Order>;
            if (orderList.isEmpty) {
              return const Center(
                child: Text(
                  "There are no items here",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (ctx, index) => Padding(
                padding: const EdgeInsets.all(0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => Navigator.pushNamed(
                    context,
                    OrderDetailPage.routeName,
                    arguments: OrderArguments(
                      orderList[index].id,
                      orderList[index].shipName,
                      orderList[index].shipPhone,
                      orderList[index].shipAddress,
                      orderList[index].orderStatus,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.storefront_rounded,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(orderList[index].shopName),
                            const Spacer(),
                            Text(
                                Orders().getOrderStatus(
                                    orderList[index].orderStatus),
                                style:
                                    const TextStyle(color: Colors.redAccent)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Flexible(
                              //   child: SizedBox(
                              //     width: 80,
                              //     height: 80,
                              //     child: Image.network(
                              //       "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Text(
                                    orderList[index].name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                orderList[index].paid ? "Paid" : "Not paid",
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${orderList[index].quantity} items"),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                children: [
                                  const TextSpan(
                                      text: "Total Payment: ",
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                      text: "\$${orderList[index].sumPrice}",
                                      style: const TextStyle(
                                          color: Colors.redAccent))
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }
}
