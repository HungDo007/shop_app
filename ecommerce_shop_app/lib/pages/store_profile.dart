import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

class StoreProfile extends StatefulWidget {
  const StoreProfile({Key? key}) : super(key: key);

  static const routeName = "/store-profile";

  @override
  State<StoreProfile> createState() => _StoreProfileState();
}

class _StoreProfileState extends State<StoreProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Store Profile"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    // color: Colors.red,
                    width: double.infinity,
                    child: Image.network(
                        "https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png"),
                    height: 150,
                  ),
                  Container(
                    color: Color.fromARGB(255, 49, 47, 47).withOpacity(0.8),
                    width: double.infinity,
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          "Click to change image",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CustomTextField(
                        title: "Store Name",
                        icon: Icons.storefront_rounded,
                      ),
                      CustomTextField(
                        title: "Phone Number",
                        icon: Icons.phone,
                      ),
                      CustomTextField(
                        title: "Address",
                        icon: Icons.location_on,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "Desciption",
                          prefixIcon: Icon(Icons.description),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                        text: "Save Changes",
                        press: () {},
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: title,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
