import 'package:flutter/material.dart';

class DiscountBanner extends StatelessWidget {
  // const DiscountBanner({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text.rich(TextSpan(
          text: "A Summer Sale\n",
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(
              text: "Cashback 10%",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )
          ])),
    );
  }
}
