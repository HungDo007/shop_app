import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/payment_page.dart';
import './pages/tab_page.dart';
import './pages/cart_page.dart';
import './pages/sign-in-page.dart';
import './pages/sign-up-page.dart';
// import './pages/edit_product.dart';
import './pages/user_tab_page.dart';
// import './pages/store_profile.dart';
import './pages/category_page.dart';
import './pages/checkout_page.dart';
import './pages/user_order_page.dart';
import 'pages/checkout_status.dart';
import './pages/order_detail_page.dart';
// import './pages/seller_order_page.dart';
import './pages/product_query_page.dart';
// import './pages/manage_product_page.dart';
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: const TabPage(),
        routes: {
          SignInPage.routeName: (context) => const SignInPage(),
          SignUpPage.routeName: (context) => const SignUpPage(),
          CartPage.routeName: (context) => const CartPage(),
          UserPage.routeName: (context) => const UserPage(),
          // EditProduct.routeName: (context) => EditProduct(),
          // StoreProfile.routeName: (context) => StoreProfile(),
          PaymentPage.routeName: (context) => const PaymentPage(),
          CheckoutPage.routeName: (context) => const CheckoutPage(),
          CategoryPage.routeName: (context) => const CategoryPage(),
          UserOrderPage.routeName: (context) => const UserOrderPage(),
          // SellerOrderPage.routeName: (context) => SellerOrderPage(),
          CheckoutStatus.routeName: (context) => const CheckoutStatus(),
          OrderDetailPage.routeName: (context) => const OrderDetailPage(),
          // ManageProductPage.routeName: (context) => ManageProductPage(),
          ProductQueryPage.routeName: (context) => const ProductQueryPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == ProductDetailPage.routeName) {
            final productId = settings.arguments as int;
            return MaterialPageRoute(
              builder: (context) => ProductDetailPage( productId: productId),
            );
          }
          return null;
        },
      ),
    );
  }
}
