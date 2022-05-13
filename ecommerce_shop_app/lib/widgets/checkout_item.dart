import 'package:flutter/material.dart';

import '../api/api_url.dart';
import '../providers/cart.dart';

class CheckoutItem extends StatelessWidget {
  // const CheckoutItem({ Key? key }) : super(key: key);
  final Cart item;

  const CheckoutItem({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Image.network(ApiUrls.baseUrl + item.productImg),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                item.details,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              Text.rich(
                TextSpan(
                    text: "\$${item.price}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
                    ),
                    children: [
                      TextSpan(
                          text: " x${item.quantity}",
                          style: const TextStyle(
                            color: Colors.grey,
                          )),
                    ]),
              )
            ],
          ),
        ),
      ],
    );
  }
}
