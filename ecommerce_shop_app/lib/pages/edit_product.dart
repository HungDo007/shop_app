import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key}) : super(key: key);

  static const routeName = "/edit-product";

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Product"),
        ),
        body: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.red,
              child: Text("Add images"),
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text("Name"),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text("Description"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
