// import '../widgets/cart/cart_item.dart';
import 'dart:developer';

import 'package:ecommerce_shop_app/providers/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/user.dart';

import '../utils/input_validation.dart';
import '../widgets/payment.dart';
// import '../widgets/checkout_item.dart';
import '../widgets/cart/shop_item.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class CheckoutPage extends StatefulWidget {
  // const CheckoutPage({Key? key}) : super(key: key);

  static const routeName = "/checkout";

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> with InputValidationMixin {
  late Future _userFuture;
  // final Map<String, String> _shipInfo = {
  //   'name': '',
  //   'phone': '',
  //   'address': '',
  // };
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  void getUser() async {
    final user = await UserMethod().getUser();
    setState(() {
      nameController.text = "${user.firstName} ${user.lastName}";
      phoneController.text = user.phoneNumber;
      addressController.text = user.address;
    });
  }

  @override
  void initState() {
    _userFuture = UserMethod().getUser();
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Check out"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: _userFuture,
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (userSnapshot.hasError) {
                      return const Center(
                        child: Text("Sorry, something went wrong!"),
                      );
                    } else {
                      // final user = userSnapshot.data as User;

                      // if (nameController.text.isEmpty) {
                      //   nameController.text =
                      //       "${user.firstName} ${user.lastName}";
                      // }
                      // if (phoneController.text.isEmpty) {
                      //   phoneController.text = user.phoneNumber;
                      // }
                      // if (addressController.text.isEmpty) {
                      //   addressController.text = user.address;
                      // }

                      // _shipInfo["name"] = "${user.firstName} ${user.lastName}";
                      // _shipInfo["phone"] = user.phoneNumber;
                      // _shipInfo["address"] = user.address;
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.redAccent),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                          text: "Ship Information\n",
                                          children: [
                                            TextSpan(
                                                text:
                                                    "\nName: ${nameController.text}\n"),
                                            TextSpan(
                                                text:
                                                    "Phone Number: ${phoneController.text}\n"),
                                            TextSpan(
                                                text:
                                                    "Address: ${addressController.text}"),
                                          ]),
                                      // overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                                "Change ship Information"),
                                            CustomTextField(
                                              title: "Name",
                                              icon: Icons.person,
                                              // value: "${_shipInfo["name"]}",
                                              controller: nameController,
                                              validate: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "This field is required";
                                                }
                                                return null;
                                              },
                                            ),
                                            CustomTextField(
                                              title: "Phone number",
                                              icon: Icons.phone,
                                              controller: phoneController,
                                              inputType: TextInputType.phone,
                                              // value: "${_shipInfo["phone"]}",
                                              validate: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'This field is required';
                                                } else if (!isPhoneValid(
                                                    value)) {
                                                  return 'Phone number is not valid';
                                                }
                                                return null;
                                              },
                                            ),
                                            CustomTextField(
                                              title: "Address",
                                              icon: Icons.location_on,
                                              controller: addressController,
                                              validate: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "This field is required";
                                                }
                                                return null;
                                              },
                                              // value: "${_shipInfo["phone"]}",
                                            ),
                                            CustomButton(
                                              text: "Submit",
                                              press: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    Navigator.pop(context);
                                                  });
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
              Consumer<Carts>(
                builder: (context, cartItem, child) => Column(
                  children: cartItem.selectedShopItems
                      .asMap()
                      .map((index, item) => MapEntry(
                            index,
                            Column(
                              children: [
                                // CheckoutItem(
                                //   item: cartItem.selectedCartItems[index],
                                // ),
                                ShopItem(
                                    shopName: cartItem.selectedShopItems[index]
                                        ["shopName"],
                                    items: cartItem.selectedShopItems[index]
                                        ["items"]),
                                const Divider(),
                              ],
                            ),
                          ))
                      .values
                      .toList(),
                ),
              ),
              Payment(),
            ],
          ),
        ),
        bottomNavigationBar: OrderCard(
          shipName: nameController.text,
          shipPhone: phoneController.text,
          shipAddress: addressController.text,
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  // const OrderCard({Key? key}) : super(key: key);

  final String shipName;
  final String shipPhone;
  final String shipAddress;

  const OrderCard({
    Key? key,
    required this.shipName,
    required this.shipPhone,
    required this.shipAddress,
  }) : super(key: key);

  // void _handleOrder() {
  //   var items = Provider.of(context).
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text.rich(
              TextSpan(text: "Total: \n", children: [
                TextSpan(
                  text: '\$${Provider.of<Carts>(context).totalAmount}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.redAccent,
                  ),
                ),
              ]),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 180,
              child: CustomButton(
                text: "Order",
                press: () async {
                  var items = Provider.of<Carts>(context, listen: false)
                      .selectedShopItems;
                  var data = items.map((item) {
                    var selectedItems = item["items"] as List<Cart>;
                    return {
                      "seller": item["seller"],
                      "shipAddress": shipAddress,
                      "shipName": shipName,
                      "shipPhonenumber": shipPhone,
                      "orderItemId":
                          selectedItems.map((e) => e.cartId).toList(),
                    };
                  }).toList();
                  await Order().order(data);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
