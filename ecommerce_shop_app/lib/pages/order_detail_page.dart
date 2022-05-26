import 'package:ecommerce_shop_app/pages/user_order_page.dart';
import 'package:flutter/material.dart';

import '../api/api_url.dart';
import '../providers/order.dart';
import '../widgets/ship_info.dart';
import '../widgets/custom_button.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  static const routeName = "/order-detail";

  @override
  Widget build(BuildContext context) {
    final orderArg =
        ModalRoute.of(context)!.settings.arguments as OrderArguments;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Order Detail"),
        ),
        body: FutureBuilder(
          future: Orders().getOrderDetail(orderArg.orderId),
          builder: (ctx, orderSnapshot) {
            if (orderSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (orderSnapshot.hasError) {
                return const Center(
                  child: Text("Sorry, something went wrong!"),
                );
              } else {
                final orderDetailList = orderSnapshot.data as List<OrderDetail>;
                var total = 0.0;
                for (var order in orderDetailList) {
                  total += order.price;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ShipInfo(
                        name: orderArg.name,
                        phoneNumber: orderArg.phoneNumber,
                        address: orderArg.address,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderDetailList.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFF5F6F9),
                                spreadRadius: 6,
                                offset: Offset.zero,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Image.network(
                                  ApiUrls.baseUrl +
                                      orderDetailList[index].productImg,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            "${orderDetailList[index].name}\n",
                                        children: [
                                          TextSpan(
                                              text: orderDetailList[index]
                                                  .details,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              )),
                                        ],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        RichText(
                                          text: TextSpan(
                                            text:
                                                "x${orderDetailList[index].quantity}\n",
                                            children: [
                                              TextSpan(
                                                text:
                                                    "\$${orderDetailList[index].price}\n",
                                                style: const TextStyle(
                                                    color: Colors.redAccent),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    if (orderArg.orderStatus == OrderStatus.inProgress.index)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomButton(
                          press: () {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      title: const Text(
                                        "Confirm",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: const Text(
                                          "Are you sure cancel this order?"),
                                      actions: [
                                        TextButton(
                                          child: const Text('No'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Yes'),
                                          onPressed: () async {
                                            try {
                                              await Orders().cancelOrder(
                                                  orderArg.orderId);
                                              Navigator.pop(context);
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      UserOrderPage.routeName);
                                            } catch (e) {
                                              rethrow;
                                            }
                                          },
                                        ),
                                      ],
                                    ));
                          },
                          text: "Cancel Order",
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          text: "Merchandise Total: ",
                          children: [
                            TextSpan(
                              text: "\$$total",
                              style: const TextStyle(color: Colors.redAccent),
                            ),
                          ],
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
