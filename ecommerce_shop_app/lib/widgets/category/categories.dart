import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/categories.dart' as category_provider;
import './category_item.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            child: const Text(
              "CATEGORY",
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(
            future: Provider.of<category_provider.Categories>(context,
                    listen: false)
                .fetchAndSetCategories(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (dataSnapshot.hasError) {
                return const Center(
                  child: Text("An error occurred"),
                );
              } else {
                return SizedBox(
                  height: 150,
                  child: Consumer<category_provider.Categories>(
                    builder: (ctx, categoryData, child) => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryData.categoryItems.length,
                      itemBuilder: (context, index) => CategoryItem(
                        categoryData.categoryItems[index].id,
                        categoryData.categoryItems[index].name,
                        categoryData.categoryItems[index].image,
                      ),
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
