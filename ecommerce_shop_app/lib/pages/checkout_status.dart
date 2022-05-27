import 'package:flutter/material.dart';

import '../providers/order.dart';

class CheckoutStatus extends StatelessWidget {
  const CheckoutStatus({Key? key}) : super(key: key);

  static const routeName = "checkout-Status";

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: FutureBuilder(
          future: Orders().checkoutStatus(arg),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.hasError) {
                return const Status(
                  color: Colors.red,
                  icon: Icons.error,
                  status: "failed",
                );
              } else {
                if (arg["isSuccess"]) {
                  return const Status(
                    color: Colors.green,
                    icon: Icons.check_circle,
                    status: "successfully",
                  );
                } else {
                  return const Status(
                    color: Colors.red,
                    icon: Icons.error,
                    status: "failed",
                  );
                }
              }
            }
          }),
    );
  }
}

class Status extends StatelessWidget {
  const Status({
    Key? key,
    required this.icon,
    required this.status,
    required this.color,
  }) : super(key: key);

  final IconData icon;
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: color,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "You placed order $status!",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: color,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
            child: const Text(
              "Go to home",
              style: TextStyle(fontSize: 24),
            ),
          )
        ],
      ),
    );
  }
}
