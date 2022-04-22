import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/category_page.dart';
import './pages/home_page.dart';
import './pages/sign-in-page.dart';
import './pages/sign-up-page.dart';
import './pages/product_detail_page.dart';

import './providers/auth.dart';
import './providers/categories.dart';
import './providers/products.dart';

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: HomePage(),
        routes: {
          "/sign-up": (context) => SignUpPage(),
          "/sign-in": (context) => SignInPage(),
          CategoryPage.routeName: (context) => CategoryPage(),
          //ProductDetailPage.routeName: (context) => ProductDetailPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == ProductDetailPage.routeName) {
            final productId = settings.arguments as int;
            return MaterialPageRoute(builder: (context) {
              return ProductDetailPage(productId);
            });
          }
        },
      ),
    );
  }
}
