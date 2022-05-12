import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/custom_button.dart';
import '../widgets/cart/shop_item.dart';

class CartPage extends StatelessWidget {
  // const CartPage({ Key? key }) : super(key: key);

  static const routName = "/cart";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Your Cart"),
        ),
        body: FutureBuilder(
          future: Provider.of<Carts>(context, listen: false).getCart(),
          builder: (context, cartSnapshot) {
            if (cartSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (cartSnapshot.hasError) {
                return const Center(
                  child: Text("An error occurred!"),
                );
              } else {
                final carts = cartSnapshot.data as List<Cart>;
                final shopItems = [];
                for (var element in carts) {
                  if (!shopItems
                      .any((item) => item["shopName"] == element.shopName)) {
                    var obj = {
                      "shopName": element.shopName,
                      "items": carts
                          .where((cart) => cart.shopName == element.shopName)
                          .toList(),
                    };
                    shopItems.add(obj);
                  }
                }
                return ListView.builder(
                  itemCount: shopItems.length,
                  itemBuilder: (ctx, index) {
                    var shopItem = shopItems[index]["items"] as List<Cart>;
                    return ShopItem(
                      shopName: shopItems[index]["shopName"],
                      items: shopItem,
                    );
                  },
                );
              }
            }
          },
        ),
        bottomNavigationBar: CheckOutCard(),
      ),
    );
  }
}

class CheckOutCard extends StatelessWidget {
  const CheckOutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.price_check_outlined),
            ),
            Text.rich(
              TextSpan(text: "Total: \n", children: [
                TextSpan(
                  text: '\$${Provider.of<Carts>(context).totalAmount}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.redAccent,
                  ),
                ),
              ]),
            ),
            SizedBox(
              width: 190,
              child: CustomButton(
                text: "Checkout",
                press: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
