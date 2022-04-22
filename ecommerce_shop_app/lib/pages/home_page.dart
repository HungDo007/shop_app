import 'package:flutter/material.dart';

import '../widgets/discount_banner.dart';
import '../widgets/product_banner.dart';
import '../widgets/category/categories.dart';
import '../widgets/product/products.dart';

class HomePage extends StatelessWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      /* Clear the search field */
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/sign-in");
            },
            icon: Icon(Icons.person),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ProductBanner(),
          ),
          SliverToBoxAdapter(
            child: Categories(),
          ),
          SliverToBoxAdapter(
            child: DiscountBanner(),
          ),
          // SliverGrid(
          //   delegate: SliverChildBuilderDelegate((context, index) {}),
          //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          //     maxCrossAxisExtent: 200,
          //     childAspectRatio: 4 / 5,
          //     crossAxisSpacing: 10,
          //     mainAxisSpacing: 10,
          //   ),

          // )
          Products()
        ],
      ),
    );
  }
}
