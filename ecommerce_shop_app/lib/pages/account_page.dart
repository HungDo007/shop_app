import 'package:flutter/material.dart';

import '../widgets/menu_item.dart';

import './sign-in-page.dart';
import './sign-up-page.dart';
import './user_profile_page.dart';
import 'user_order_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png"),
          ),
        ),
        title: Text("Username"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, SignInPage.routeName);
              },
              child: const Text("Sign In"),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.orange,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, SignUpPage.routeName);
              },
              child: const Text("Sign Up"),
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                side: const BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            MenuItem(
              text: "Profile",
              icon: (Icons.account_box_rounded),
              press: () {
                Navigator.pushNamed(context, UserProfilePage.routeName);
              },
            ),
            MenuItem(
              text: "Order",
              icon: (Icons.receipt_long),
              press: () =>
                  Navigator.pushNamed(context, UserOrderPage.routeName),
            ),
            MenuItem(
              text: "Notification",
              icon: (Icons.notifications),
              press: () {},
            ),
            MenuItem(
              text: "Settings",
              icon: (Icons.settings),
              press: () {},
            ),
            MenuItem(
              text: "Help Center",
              icon: (Icons.help_center),
              press: () {},
            ),
            MenuItem(
              text: "Log Out",
              icon: (Icons.logout),
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
