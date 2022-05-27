import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products.dart' as product_provider;
import './product_item.dart';

class Products extends StatelessWidget {
  final int categoryId;
  final String keyword;

  const Products(this.categoryId, this.keyword, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<product_provider.Products>(context, listen: false)
          .fetchAndSetProducts(categoryId, keyword),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (dataSnapshot.hasError) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text("An error occurred! Failed to load products"),
            ),
          );
        } else {
          final products = dataSnapshot.data as List<product_provider.Product>;
          if (products.isEmpty) {
            return const Center(
              child: Text(
                "There are no items here",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            );
          }
          return SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 4 / 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ProductItem(
                  products[index].id,
                  products[index].name,
                  products[index].poster,
                  products[index].price,
                );
              },
              childCount: products.length,
            ),
          );
        }
      },
    );
  }
}
