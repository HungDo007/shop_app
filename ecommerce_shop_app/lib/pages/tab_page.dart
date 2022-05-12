import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';

import './home_page.dart';
import './cart_page.dart';
import './store_page.dart';
import './account_page.dart';
import './sign-in-page.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = [
    HomePage(),
    // StorePage(),
    AccountPage(),
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
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
            if (Provider.of<Auth>(context, listen: false).isAuthenticate)
              Consumer<Carts>(
                builder: (ctx, cartData, ch) => Badge(
                  value: cartData.itemCount.toString(),
                  child: ch!,
                ),
                child: IconButton(
                  onPressed: () {
                    Provider.of<Auth>(context, listen: false).isAuthenticate
                        ? Navigator.pushNamed(context, CartPage.routName)
                        : Navigator.pushNamed(context, SignInPage.routeName);
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ),
          ],
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            // BottomNavigationBarItem(icon: Icon(Icons.store), label: "Store"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
          ],
        ),
      ),
    );
  }
}
