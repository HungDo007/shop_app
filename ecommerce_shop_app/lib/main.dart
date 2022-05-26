import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/tab_page.dart';
import './pages/cart_page.dart';
import './pages/sign-in-page.dart';
import './pages/sign-up-page.dart';
import './pages/edit_product.dart';
import './pages/user_tab_page.dart';
import './pages/store_profile.dart';
import './pages/category_page.dart';
import './pages/checkout_page.dart';
import './pages/user_order_page.dart';
import './pages/order_detail_page.dart';
import './pages/seller_order_page.dart';
import './pages/product_query_page.dart';
import './pages/manage_product_page.dart';
import './pages/product_detail_page.dart';

import './providers/auth.dart';
import './providers/cart.dart';
import './providers/products.dart';
import './providers/categories.dart';

import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Categories(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Carts(),
        ),
        // ChangeNotifierProvider.value(
        //   create: (ctx) => Cart()),

        // ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: TabPage(),
        routes: {
          CartPage.routeName: (context) => CartPage(),
          SignInPage.routeName: (context) => SignInPage(),
          SignUpPage.routeName: (context) => SignUpPage(),
          UserPage.routeName: (context) => const UserPage(),
          CategoryPage.routeName: (context) => CategoryPage(),
          StoreProfile.routeName: (context) => StoreProfile(),
          UserOrderPage.routeName: (context) => UserOrderPage(),
          ManageProductPage.routeName: (context) => ManageProductPage(),
          SellerOrderPage.routeName: (context) => SellerOrderPage(),
          EditProduct.routeName: (context) => EditProduct(),
          CheckoutPage.routeName: (context) => CheckoutPage(),
          OrderDetailPage.routeName: (context) => OrderDetailPage(),
          ProductQueryPage.routeName: (context) => ProductQueryPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == ProductDetailPage.routeName) {
            final productId = settings.arguments as int;
            return MaterialPageRoute(
              builder: (context) => ProductDetailPage(productId),
            );
          }
          return null;
        },
      ),
    );
  }
}
