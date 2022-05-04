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
          title: Text("Manage Product"),
          actions: [
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, EditProduct.routeName),
              icon: Icon(Icons.add_box_rounded),
              tooltip: "Add product",
            )
          ],
        ),
        body: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => Divider(height: 1),
          itemBuilder: (ctx, index) => ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
            ),
            title: Text("Product name"),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                      color: Theme.of(context).primaryColor),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete),
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
