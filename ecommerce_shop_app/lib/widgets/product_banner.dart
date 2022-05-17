import 'package:flutter/material.dart';

class ProductBanner extends StatelessWidget {
  // const ProductBanner({ Key? key }) : super(key: key);

  List<String> images = [
    "assets/images/banner1.jpg",
    "assets/images/banner2.jpg",
    "assets/images/banner3.jpg",
    "assets/images/banner4.jpg",
    "assets/images/banner5.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: PageView.builder(
        itemCount: images.length,
        // pageSnapping: true,
        itemBuilder: (context, pagePosition) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Image.asset(
              images[pagePosition],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
