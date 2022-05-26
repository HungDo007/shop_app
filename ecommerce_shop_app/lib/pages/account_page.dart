import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../widgets/menu_item.dart';

import './sign-in-page.dart';
import './sign-up-page.dart';
import './user_order_page.dart';
import './user_tab_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  List<Widget> _buildAction(BuildContext context) {
    return [
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context, listen: false).userInfo;
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png"),
          ),
        ),
        title: Text(user.username),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: user.username.isEmpty ? _buildAction(context) : null,
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
                Provider.of<Auth>(context, listen: false).isAuthenticate
                    ? Navigator.pushNamed(context, UserPage.routeName)
                    : Navigator.pushNamed(context, SignInPage.routeName);
              },
            ),
            MenuItem(
                text: "Order",
                icon: (Icons.receipt_long),
                press: () {
                  Provider.of<Auth>(context, listen: false).isAuthenticate
                      ? Navigator.pushNamed(context, UserOrderPage.routeName)
                      : Navigator.pushNamed(context, SignInPage.routeName);
                }),
            // MenuItem(
            //   text: "Notification",
            //   icon: (Icons.notifications),
            //   press: () {},
            // ),
            // MenuItem(
            //   text: "Settings",
            //   icon: (Icons.settings),
            //   press: () {},
            // ),
            // MenuItem(
            //   text: "Help Center",
            //   icon: (Icons.help_center),
            //   press: () {},
            // ),
            if (user.username.isNotEmpty)
              MenuItem(
                text: "Sign Out",
                icon: (Icons.logout),
                press: () {
                  Provider.of<Auth>(context, listen: false).signOut();
                  Navigator.pushReplacementNamed(context, "/");
                },
              )
          ],
        ),
      ),
    );
  }
}
