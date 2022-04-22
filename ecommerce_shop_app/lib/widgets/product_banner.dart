import 'package:flutter/material.dart';

class ProductBanner extends StatelessWidget {
  // const ProductBanner({ Key? key }) : super(key: key);

  List<String> images = [
    "assets/images/shop_banner/banner1.jpg",
    "assets/images/shop_banner/banner2.jpg",
    "assets/images/shop_banner/banner3.jpg",
    "assets/images/shop_banner/banner4.jpg",
    "assets/images/shop_banner/banner5.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
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
