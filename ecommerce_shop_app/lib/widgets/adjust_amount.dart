import 'package:flutter/material.dart';

import './rounded_icon.dart';

class AdjustAmount extends StatefulWidget {
  // const AdjustAmount({Key? key}) : super(key: key);
  final int stock;
  int amount;
  AdjustAmount(this.stock, this.amount);
  @override
  State<AdjustAmount> createState() => _AdjustAmountState();
}

class _AdjustAmountState extends State<AdjustAmount> {
  // int _amount = 1;

  void _decreaseAmount() {
    if (widget.amount > 1) {
      setState(() {
        widget.amount -= 1;
      });
    }
  }

  void _increaseAmount() {
    if (widget.amount < widget.stock) {
      setState(() {
        widget.amount += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Amount"),
        const Spacer(flex: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            RoundedIconButton(icon: Icons.remove, press: _decreaseAmount),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(widget.amount.toString()),
            ),
            RoundedIconButton(icon: Icons.add, press: _increaseAmount),
          ]),
        ),
        const Spacer(),
        Text("${widget.stock} available")
      ],
    );
  }
}

