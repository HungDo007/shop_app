import 'package:flutter/material.dart';

import '../widgets/product/products.dart';
import '../widgets/product_banner.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);
  static const routeName = "/category";

  @override
  Widget build(BuildContext context) {
    final category =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(title: const Text("Products"),),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(category["name"]),
              floating: true,
            ),
            SliverToBoxAdapter(
              child: ProductBanner(),
            ),
            Products(category["id"], ""),
          ],
        ),
      ),
    );
  }
}
