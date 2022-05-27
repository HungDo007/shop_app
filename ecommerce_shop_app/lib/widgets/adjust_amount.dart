import 'package:flutter/material.dart';

import './rounded_icon.dart';

class AdjustAmount extends StatefulWidget {
  // const AdjustAmount({Key? key}) : super(key: key);
  final int stock;
  final int amount;
  const AdjustAmount(this.stock, this.amount, {Key? key}) : super(key: key);
  @override
  State<AdjustAmount> createState() => _AdjustAmountState();
}

class _AdjustAmountState extends State<AdjustAmount> {
  // int _amount = 1;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Amount"),
        const Spacer(flex: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            RoundedIconButton(icon: Icons.remove, press: (){}),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(widget.amount.toString()),
            ),
            RoundedIconButton(icon: Icons.add, press: (){}),
          ]),
        ),
        const Spacer(),
        Text("${widget.stock} available")
      ],
    );
  }
}

