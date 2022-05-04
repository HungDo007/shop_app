import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_url.dart';
import '../providers/products.dart';
import '../widgets/custom_button.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);
  static const routeName = "/product-detail";

  // final int productId;

  // ProductDetailPage(this.productId);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as int;
    return FutureBuilder(
      future: Provider.of<Products>(context).fetchProductDetail(productId),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (dataSnapshot.error != null) {
            return const Center(
              child: Text("An error occurred"),
            );
          } else {
            final product = dataSnapshot.data as Product;

            product.images.insert(0, product.poster);
            return SafeArea(
              child: Scaffold(
                backgroundColor: Color(0xFFF5F6F9),
                // extendBodyBehindAppBar: true,
                appBar: AppBar(
                  title: Text(product.name),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: PageView.builder(
                          itemCount: product.images.length,
                          // pageSnapping: true,
                          itemBuilder: (context, pagePosition) {
                            return Container(
                              child: Image.network(
                                ApiUrls.baseUrl + product.images[pagePosition],
                                fit: BoxFit.contain,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      TopRoundedContainer(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                product.name,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 64,
                              ),
                              child: Text(
                                "\$${product.price}",
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 24),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 64,
                              ),
                              child: Text(
                                product.description,
                                maxLines: 3,
                              ),
                            ),
                            TopRoundedContainer(
                              color: Color(0xFFF6F7F9),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    // Text("Component detail"),
                                    // Spacer(),
                                    RoundedIconButton(
                                        icon: Icons.remove, press: () {}),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text("1"),
                                    ),
                                    RoundedIconButton(
                                        icon: Icons.add, press: () {}),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                bottomNavigationBar: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, -15),
                        blurRadius: 20,
                        color: Color(0xFFDADADA).withOpacity(0.15),
                      )
                    ],
                  ),
                  child: SafeArea(
                      child: SizedBox(
                    width: 190,
                    child: CustomButton(
                      text: "ADD TO CARD",
                      press: () {},
                    ),
                  )),
                ),
              ),
            );
          }
        }
      },
    );
  }
}

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer(
      {Key? key, required this.color, required this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    Key? key,
    required this.icon,
    required this.press,
    this.showShadow = false,
  }) : super(key: key);

  final IconData icon;
  final GestureTapCancelCallback press;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          if (showShadow)
            BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 10,
              color: const Color(0xFFB0B0B0).withOpacity(0.2),
            ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: const Color(0xFFFF7643),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
