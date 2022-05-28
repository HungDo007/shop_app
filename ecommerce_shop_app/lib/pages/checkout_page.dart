import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/user.dart';
import '../providers/order.dart';

import './payment_page.dart';
import '../utils/input_validation.dart';
import '../widgets/ship_info.dart';
import '../widgets/payment.dart';
// import '../widgets/checkout_item.dart';
import '../widgets/cart/shop_item.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

enum PaymentMethod { cash, paypal }

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  static const routeName = "/checkout";

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> with InputValidationMixin {
  PaymentMethod _method = PaymentMethod.cash;

  late Future _userFuture;

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

  void _selectMethod(PaymentMethod? value) {
    setState(() {
      _method = value!;
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
                              ShipInfo(
                                  name: nameController.text,
                                  phoneNumber: phoneController.text,
                                  address: addressController.text),
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
                                icon: const Icon(Icons.arrow_forward_ios,
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
              Payment(method: _method, selectMethod: _selectMethod),
            ],
          ),
        ),
        bottomNavigationBar: OrderCard(
          shipName: nameController.text,
          shipPhone: phoneController.text,
          shipAddress: addressController.text,
          paymentMethod: _method,
        ),
      ),
    );
  }
}

class OrderCard extends StatefulWidget {
  final String shipName;
  final String shipPhone;
  final String shipAddress;
  final PaymentMethod paymentMethod;

  const OrderCard({
    Key? key,
    required this.shipName,
    required this.shipPhone,
    required this.shipAddress,
    required this.paymentMethod,
  }) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _isLoading = false;

  void _handleOrder(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    var items = Provider.of<Carts>(context, listen: false).selectedShopItems;
    var data = items.map((item) {
      var selectedItems = item["items"] as List<Cart>;
      return {
        "seller": item["seller"],
        "shipAddress": widget.shipAddress,
        "shipName": widget.shipName,
        "shipPhonenumber": widget.shipPhone,
        "orderItemId": selectedItems.map((e) => e.cartId).toList(),
      };
    }).toList();
    try {
      if (widget.paymentMethod == PaymentMethod.cash) {
        await Orders().order(data);
        Provider.of<Carts>(context, listen: false).getCart();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(Icons.error, color: Colors.green),
                SizedBox(
                  width: 10,
                ),
                Text('Order Successfully!'),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            backgroundColor: Colors.grey,
            duration: const Duration(milliseconds: 1500),
          ),
        );
        Navigator.pushNamed(context, "/");
      } else {
        final url = await Orders().orderPayPal(data);
        Provider.of<Carts>(context, listen: false).getCart();
        Navigator.pushNamed(context, PaymentPage.routeName, arguments: url);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.error, color: Colors.red),
              SizedBox(
                width: 10,
              ),
              Text('Order failed!'),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.grey,
          duration: const Duration(milliseconds: 1500),
        ),
      );
      rethrow;
    }
  }

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
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
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
                text: _isLoading ? null : "Order",
                press: () => _handleOrder(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
