import 'package:flutter/material.dart';

import '../../providers/cart.dart';
import './cart_item.dart';

class ShopItem extends StatelessWidget {
  final String shopName;
  final List<Cart> items;

  const ShopItem({Key? key, required this.shopName, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFF5F6F9),
            spreadRadius: 8,
            offset: Offset.zero, // changes position of shadow
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.store_mall_directory_rounded),
              const SizedBox(
                width: 5,
              ),
              Text(shopName),
            ],
          ),
          Column(
              children: items
                  .asMap()
                  .map((index, cartItem) => MapEntry(
                        index,
                        Column(
                          children: [
                            CartItem(
                              cartItem: items[index],
                            ),
                            const Divider(
                              height: 1,
                            ),
                          ],
                        ),
                      ))
                  .values
                  .toList()),
        ],
      ),
    );
  }
}
