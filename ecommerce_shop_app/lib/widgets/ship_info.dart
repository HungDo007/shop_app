import 'package:flutter/material.dart';

class ShipInfo extends StatelessWidget {
  const ShipInfo({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.address,
  }) : super(key: key);

  final String name;
  final String phoneNumber;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.location_on, color: Colors.redAccent),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: RichText(
            text: TextSpan(
                text: "Ship Information\n",
                children: [
                  TextSpan(text: "\nName: $name\n"),
                  TextSpan(text: "Phone Number: $phoneNumber\n"),
                  TextSpan(text: "Address: $address"),
                ],
                style: const TextStyle(color: Colors.black, fontSize: 16)),
            // overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
