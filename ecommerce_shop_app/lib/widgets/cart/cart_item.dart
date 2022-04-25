import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 88,
        child: AspectRatio(
          aspectRatio: 0.88,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFF5F6F9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.network(
                "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
          ),
        ),
      ),
      const SizedBox(
        width: 20,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Product",
            style: TextStyle(fontSize: 16, color: Colors.black),
            maxLines: 2,
          ),
          SizedBox(
            height: 10,
          ),
          Text.rich(
            TextSpan(
                text: "price",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
                children: [
                  TextSpan(
                      text: " x2",
                      style: TextStyle(
                        color: Colors.grey,
                      )),
                ]),
          )
        ],
      )
    ]);
  }
}
