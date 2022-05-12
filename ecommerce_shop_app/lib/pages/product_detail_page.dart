import 'dart:developer';
import 'package:ecommerce_shop_app/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/products.dart' as product_provider;

// import '../widgets/component_detail.dart';
// import '../widgets/adjust_amount.dart';
import './sign-in-page.dart';
import '../widgets/custom_button.dart';
import '../widgets/rounded_icon.dart';
import '../api/api_url.dart';
import '../utils/handle.dart';

class ProductDetailPage extends StatefulWidget {
  // const ProductDetailPage({Key? key}) : super(key: key);
  static const routeName = "/product-detail";

  final int productId;
  ProductDetailPage(this.productId);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // final int productId;
  late Future _productDetailFuture;

  num price = -1;
  int availableStock = -1;

  var selected = [];

  var cartItem = {
    "productDetailId": null,
    "amount": 1,
  };

  List<product_provider.ProductDetail> productDetails = [];
  Future _getProductDetail(int productId) {
    return Provider.of<product_provider.Products>(context, listen: false)
        .fetchProductDetail(productId);
  }

  void _decreaseAmount() {
    if (cartItem["amount"]! > 1) {
      setState(() {
        cartItem["amount"] = cartItem["amount"]! - 1;
      });
    }
  }

  void _increaseAmount() {
    if (cartItem["amount"]! < availableStock) {
      setState(() {
        cartItem["amount"] = cartItem["amount"]! + 1;
      });
    }
  }

  Future<void> _addToCart() async {
    final isAuth = Provider.of<Auth>(context, listen: false).isAuthenticate;
    if (isAuth) {
      try {
        await Provider.of<Carts>(context, listen: false).addToCart(
            cartItem["productDetailId"] ?? 0, cartItem["amount"] ?? 1);
        // await Carts().addToCart(
        //     cartItem["productDetailId"] ?? 0, cartItem["amount"] ?? 1);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Add product to cart successfully!'),
          ),
        );
      } catch (e) {
        rethrow;
      }
    } else {
      Navigator.pushNamed(context, SignInPage.routeName);
    }
    // print(user.username);
  }

  void _handlePriceAndStock() {
    // inspect(productDetails);
    if (selected.length == productDetails[0].componentDetails.length) {
      var a = productDetails.map((item) {
        var obj = [];
        for (var element in item.componentDetails) {
          obj.add(element.id);
        }
        return obj;
      }).toList();

      var b = [];
      for (var element in selected) {
        b.add(element["id"]);
      }

      var newProductDetailId = 0;
      var newPrice = 0.0;
      var newStock = 0;

      a.asMap().forEach((key, value) {
        if (value.every((item) => b.contains(item))) {
          newProductDetailId = productDetails[key].id;
          newPrice = productDetails[key].price;
          newStock = productDetails[key].stock;
        }
      });
      setState(() {
        cartItem["productDetailId"] = newProductDetailId;
        price = newPrice;
        availableStock = newStock;
      });
    }
  }

  void _handleCompo(int id, int idx) {
    var item = {
      "id": id,
      "index": idx,
    };
    if (selected.any((item) => item["index"] == idx)) {
      setState(() {
        selected.removeWhere((item) => item["index"] == idx);
        selected.add(item);
      });
    } else {
      setState(() {
        selected.add(item);
      });
    }
    _handlePriceAndStock();
  }

  @override
  void initState() {
    _productDetailFuture = _getProductDetail(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final productId = ModalRoute.of(context)!.settings.arguments as int;

    return FutureBuilder(
      future: _productDetailFuture,
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (dataSnapshot.error != null) {
            return const Scaffold(
              body: Center(
                child: Text("An error occurred"),
              ),
            );
          } else {
            final product = dataSnapshot.data as product_provider.Product;
            product.images.insert(0, product.poster);
            productDetails = product.productDetails;
            final componentList = Handle.getListComponent(productDetails);
            if (productDetails[0].componentDetails.isEmpty) {
              cartItem["productDetailId"] = productDetails[0].id;
            }
            if (availableStock == -1) {
              for (var element in productDetails) {
                availableStock += element.stock;
              }
            }
            if (price == -1) {
              price = product.price;
            }
            return SafeArea(
              child: Scaffold(
                backgroundColor: const Color(0xFFF5F6F9),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                product.name,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 64,
                              ),
                              child: Text(
                                "\$$price",
                                style: const TextStyle(
                                    color: Colors.redAccent, fontSize: 24),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 64,
                              ),
                              child: Text(
                                product.description,
                                maxLines: 3,
                              ),
                            ),
                            TopRoundedContainer(
                              color: const Color(0xFFF6F7F9),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child:
                                          // ComponentDetail(componentList, price),
                                          Column(
                                        children: componentList
                                            .asMap()
                                            .map((index, item) {
                                              return MapEntry(
                                                index,
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child:
                                                              Text(item.name)),
                                                      Expanded(
                                                        flex: 4,
                                                        child: Wrap(
                                                          children: item.value
                                                              .map(
                                                                  (value) =>
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4),
                                                                        child:
                                                                            OutlinedButton(
                                                                          style:
                                                                              OutlinedButton.styleFrom(
                                                                            minimumSize:
                                                                                const Size(80, 50),
                                                                            backgroundColor: selected.map((e) => e["id"]).contains(value.id)
                                                                                ? const Color(0xFFFF7643)
                                                                                : null,
                                                                            primary: selected.map((e) => e["id"]).contains(value.id)
                                                                                ? Colors.white
                                                                                : null,
                                                                          ),
                                                                          onPressed: () => _handleCompo(
                                                                              value.id,
                                                                              index),
                                                                          child:
                                                                              Text(value.name),
                                                                        ),
                                                                      ))
                                                              .toList(),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                            .values
                                            .toList(),
                                      )),
                                  TopRoundedContainer(
                                    color: Colors.white,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child:
                                            // AdjustAmount(availableStock,
                                            //     cartItem["amount"] ?? 1),
                                            Row(
                                          children: [
                                            const Text("Amount"),
                                            const Spacer(flex: 8),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Row(children: [
                                                RoundedIconButton(
                                                    icon: Icons.remove,
                                                    press: _decreaseAmount),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(cartItem["amount"]
                                                      .toString()),
                                                ),
                                                RoundedIconButton(
                                                    icon: Icons.add,
                                                    press: _increaseAmount),
                                              ]),
                                            ),
                                            const Spacer(),
                                            Text("$availableStock available")
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                bottomNavigationBar: Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, -15),
                        blurRadius: 20,
                        color: const Color(0xFFDADADA).withOpacity(0.15),
                      )
                    ],
                  ),
                  child: SafeArea(
                    child: SizedBox(
                      width: 190,
                      child: CustomButton(
                        text: "ADD TO CART",
                        press: availableStock == 0 ||
                                cartItem["productDetailId"] == 0 ||
                                cartItem["productDetailId"] == null
                            ? null
                            : _addToCart,
                      ),
                    ),
                  ),
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
