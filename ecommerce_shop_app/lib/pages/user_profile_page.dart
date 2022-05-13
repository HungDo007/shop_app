import 'package:ecommerce_shop_app/api/api_url.dart';
import 'package:flutter/material.dart';

import '../providers/user.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  static const routeName = "/user-profile";

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  DateTime? _selectedDate;
  final _dateOfBirthController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990, 1),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dateOfBirthController.text = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Profile"),
        ),
        body: FutureBuilder(
          future: UserMethod().getUser(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (userSnapshot.hasError) {
                return const Center(
                  child: Text("An error occurred!"),
                );
              } else {
                final user = userSnapshot.data as User;
                _dateOfBirthController.text = user.birthDay.toString();
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: SizedBox(
                          height: 115,
                          width: 115,
                          child: Stack(
                            fit: StackFit.expand,
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  ApiUrls.baseUrl + user.avatar,
                                ),
                                backgroundColor: const Color(0xFFDADADA),
                              ),
                              Positioned(
                                right: -12,
                                bottom: -18,
                                child: SizedBox(
                                  height: 46,
                                  width: 46,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Icon(Icons.camera_alt),
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: const BorderSide(
                                              color: Colors.white),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color(0xFFF5F6F9),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Form(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              CustomTextField(
                                title: "First Name",
                                icon: Icons.account_circle,
                                value: user.firstName,
                              ),
                              CustomTextField(
                                title: "Last Name",
                                icon: Icons.account_circle,
                                value: user.lastName,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: "Date of birth",
                                  prefixIcon: const Icon(Icons.date_range),
                                ),
                                onTap: () => _selectDate(context),
                                readOnly: true,
                                controller: _dateOfBirthController,
                              ),
                              CustomTextField(
                                title: "Email",
                                icon: Icons.email,
                                value: user.email,
                              ),
                              CustomTextField(
                                title: "Phone Number",
                                icon: Icons.phone,
                                value: user.phoneNumber,
                              ),
                              CustomTextField(
                                title: "Address",
                                icon: Icons.location_on,
                                value: user.address,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomButton(
                                text: "Save Changes",
                                press: () {},
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
