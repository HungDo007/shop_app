import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products.dart' as product_provider;
import './product_item.dart';

class Products extends StatelessWidget {
  final int categoryId;
  final String keyword;

  Products(this.categoryId, this.keyword);

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
                padding: EdgeInsets.symmetric(vertical: 50),
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (dataSnapshot.hasError) {
          print(dataSnapshot.error);
          return const SliverToBoxAdapter(
            child: Center(
              child: Text("An error occurred"),
            ),
          );
        } else {
          return Consumer<product_provider.Products>(
            builder: (ctx, products, child) => SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 4 / 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ProductItem(
                    products.productItems[index].id,
                    products.productItems[index].name,
                    products.productItems[index].poster,
                    products.productItems[index].price,
                  );
                },
                childCount: products.productItems.length,
              ),
            ),
          );
        }
      },
    );
  }
}
