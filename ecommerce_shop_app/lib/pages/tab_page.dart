import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';

import './home_page.dart';
import './cart_page.dart';
// import './store_page.dart';
import './account_page.dart';
import './sign-in-page.dart';
import './product_query_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;
  final _queryController = TextEditingController();
  // String _query = "";
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
  void initState() {
    _queryController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  textInputAction: TextInputAction.search,
                  controller: _queryController,
                  onSubmitted: (keyword) {
                    if (keyword.length >= 2) {
                      Navigator.pushNamed(context, ProductQueryPage.routeName,
                          arguments: keyword);
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _queryController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _queryController.clear();
                                });
                              },
                            )
                          : null,
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
                          ? Navigator.pushNamed(context, CartPage.routeName)
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
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Account"),
            ],
          ),
        ),
      ),
    );
  }
}
