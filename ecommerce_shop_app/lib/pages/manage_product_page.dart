import 'package:flutter/material.dart';

import './edit_product.dart';

class ManageProductPage extends StatelessWidget {
  const ManageProductPage({Key? key}) : super(key: key);

  static const routeName = "/manage-product";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Manage Product"),
          actions: [
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, EditProduct.routeName),
              icon: const Icon(Icons.add_box_rounded),
              tooltip: "Add product",
            )
          ],
        ),
        body: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (ctx, index) => ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
            ),
            title: const Text("Product name"),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      color: Theme.of(context).primaryColor),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
