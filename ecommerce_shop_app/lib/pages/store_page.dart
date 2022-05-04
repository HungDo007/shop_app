import 'package:flutter/material.dart';

import './store_profile.dart';
import './seller_order_page.dart';
import './manage_product_page.dart';

import '../widgets/menu_item.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFF5F6F9),
                    spreadRadius: 8,
                    offset: Offset.zero, // changes position of shadow
                  )
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Shop name")
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            MenuItem(
              text: "Store Profile",
              icon: Icons.store,
              press: () => Navigator.pushNamed(context, StoreProfile.routeName),
            ),
            MenuItem(
              text: "Product",
              icon: Icons.assignment_outlined,
              press: () =>
                  Navigator.pushNamed(context, ManageProductPage.routeName),
            ),
            MenuItem(
              text: "Order",
              icon: Icons.playlist_add_check,
              press: () =>
                  Navigator.pushNamed(context, SellerOrderPage.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
