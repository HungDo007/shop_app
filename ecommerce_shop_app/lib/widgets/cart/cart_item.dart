import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/api_url.dart';
import '../../providers/cart.dart';
import '../../pages/cart_page.dart';

class CartItem extends StatelessWidget {
  final Cart cartItem;

  const CartItem({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(cartItem.cartId.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).errorColor,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onDismissed: (direction) {
        Provider.of<Carts>(context, listen: false)
            .removeCartItem([cartItem.cartId]);
      },
      child: Row(
        children: [
          if (ModalRoute.of(context)?.settings.name == CartPage.routeName)
            Consumer<Carts>(
              builder: (context, cart, child) => Checkbox(
                  value: cartItem.selected,
                  onChanged: (value) {
                    cart.setSelected(cartItem.cartId, value!);
                  }),
            ),
          Flexible(
            child: SizedBox(
              width: 88,
              child: AspectRatio(
                aspectRatio: 0.88,
                child: Image.network(ApiUrls.baseUrl + cartItem.productImg),
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
                  cartItem.name,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  cartItem.details,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text.rich(
                  TextSpan(
                      text: "\$${cartItem.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent,
                      ),
                      children: [
                        TextSpan(
                            text: " x${cartItem.quantity}",
                            style: const TextStyle(
                              color: Colors.grey,
                            )),
                      ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
