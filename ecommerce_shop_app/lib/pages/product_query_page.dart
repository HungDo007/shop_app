import 'package:flutter/material.dart';

import '../widgets/product/products.dart';

class ProductQueryPage extends StatelessWidget {
  const ProductQueryPage({Key? key}) : super(key: key);
  static const routeName = "/product-query";

  @override
  Widget build(BuildContext context) {
    final keyword = ModalRoute.of(context)!.settings.arguments as String;
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(title: const Text("Products"),),
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text("Products"),
              floating: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Search for '$keyword'",
                  style: const TextStyle(
                      fontSize: 18, fontStyle: FontStyle.italic),
                ),
              ),
            ),
            Products(0, keyword),
          ],
        ),
      ),
    );
  }
}
