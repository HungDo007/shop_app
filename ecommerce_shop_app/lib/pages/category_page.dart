import 'package:flutter/material.dart';

import '../widgets/product/products.dart';
import '../widgets/product_banner.dart';

class CategoryPage extends StatelessWidget {
  // const CategoryPage({ Key? key }) : super(key: key);
  static const routeName = "/category";

  @override
  Widget build(BuildContext context) {
    final categoryId = ModalRoute.of(context)!.settings.arguments as int;
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(title: const Text("Products"),),
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text(
                "Products",
                style: TextStyle(color: Colors.white),
              ),
              floating: true,
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
            ),
            SliverToBoxAdapter(
              child: ProductBanner(),
            ),
            Products(categoryId, ""),
          ],
        ),
      ),
    );
  }
}
