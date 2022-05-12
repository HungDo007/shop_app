import 'package:flutter/material.dart';

import '../widgets/discount_banner.dart';
import '../widgets/product_banner.dart';
import '../widgets/category/categories.dart';
import '../widgets/product/products.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ProductBanner(),
            ),
            SliverToBoxAdapter(
              child: Categories(),
            ),
            // SliverToBoxAdapter(
            //   child: DiscountBanner(),
            // ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(5),
                child: const Text(
                  "PRODUCT",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Products(0, ""),
          ],
        ),
      ),
    );
  }
}
