import 'package:flutter/material.dart';

import '../pages/checkout_page.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key, this.method, this.selectMethod}) : super(key: key);

  final PaymentMethod? method;
  final void Function(PaymentMethod? value)? selectMethod;

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Payment method"),
            RadioListTile<PaymentMethod>(
              title: const Text("Cash On Delivery"),
              secondary: Icon(
                Icons.monetization_on,
                color: Theme.of(context).primaryColor,
              ),
              value: PaymentMethod.cash,
              groupValue: widget.method,
              onChanged: widget.selectMethod,
            ),
            RadioListTile<PaymentMethod>(
              title: const Text("Paypal"),
              secondary: Icon(
                Icons.payment,
                color: Theme.of(context).primaryColor,
              ),
              value: PaymentMethod.paypal,
              groupValue: widget.method,
              onChanged: widget.selectMethod,
            ),
          ],
        ),
      ),
    );
  }
}
