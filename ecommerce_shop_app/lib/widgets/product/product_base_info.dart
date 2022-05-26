import 'package:flutter/material.dart';

class ProductBaseInfo extends StatelessWidget {
  const ProductBaseInfo({
    Key? key,
    required this.name,
    required this.price,
    required this.description,
  }) : super(key: key);

  final String name;
  final num price;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            name,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 64,
          ),
          child: Text(
            "\$$price",
            style: const TextStyle(color: Colors.redAccent, fontSize: 24),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 64,
          ),
          child: Text(
            description,
          ),
        ),
      ],
    );
  }
}
