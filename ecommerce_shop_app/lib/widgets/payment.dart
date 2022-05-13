import 'package:flutter/material.dart';

enum PaymentMethod { cash }

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final PaymentMethod? _method = PaymentMethod.cash;

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
                value: PaymentMethod.cash,
                groupValue: _method,
                onChanged: (value) {
                  // setState(() {
                  //   _method = value;
                  // });
                }),
          ],
        ),
      ),
    );
  }
}
