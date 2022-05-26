import 'package:flutter/material.dart';

class CheckoutSuccess extends StatelessWidget {
  const CheckoutSuccess({Key? key}) : super(key: key);

  static const routeName = "checkout-success";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Checkout Success"),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
            child: Text("Go to home"))
      ],
    );
  }
}
