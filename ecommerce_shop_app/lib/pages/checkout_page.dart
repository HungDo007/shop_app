// import '../widgets/cart/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/user.dart';
import '../widgets/payment.dart';
import '../widgets/checkout_item.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  static const routeName = "/checkout";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Check out"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: UserMethod().getUser(),
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (userSnapshot.hasError) {
                      print(userSnapshot.error);
                      return const Center(
                        child: Text("Sorry, something went wrong!"),
                      );
                    } else {
                      final user = userSnapshot.data as User;
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Ship Information"),
                              CustomTextField(
                                title: "Name",
                                icon: Icons.person,
                                value: "${user.firstName} ${user.lastName}",
                              ),
                              CustomTextField(
                                title: "Phone number",
                                icon: Icons.phone,
                                value: user.phoneNumber,
                              ),
                              CustomTextField(
                                title: "Address",
                                icon: Icons.location_on,
                                value: user.address,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
              Card(
                margin: const EdgeInsets.all(10),
                child: Consumer<Carts>(
                  builder: (context, cartItem, child) => Column(
                    children: cartItem.selectedCartItems
                        .asMap()
                        .map((index, item) => MapEntry(
                              index,
                              Column(
                                children: [
                                  CheckoutItem(
                                    item: cartItem.selectedCartItems[index],
                                  ),
                                  const Divider(
                                    height: 1,
                                  ),
                                ],
                              ),
                            ))
                        .values
                        .toList(),
                  ),
                ),
              ),
              Payment(),
            ],
          ),
        ),
        bottomNavigationBar: OrderCard(),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 180,
              child: CustomButton(
                text: "Order",
                press: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
