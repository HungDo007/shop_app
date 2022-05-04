import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png",
                        ),
                      ),
                      Positioned(
                        right: -12,
                        bottom: 0,
                        child: SizedBox(
                          height: 46,
                          width: 46,
                          child: TextButton(
                            onPressed: () {},
                            child: const Icon(Icons.camera_alt),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: const BorderSide(color: Colors.white),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
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
                      ),
                      CustomTextField(
                        title: "Last Name",
                        icon: Icons.account_circle,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "Date of birth",
                          prefixIcon: Icon(Icons.date_range),
                        ),
                        onTap: () => _selectDate(context),
                        readOnly: true,
                        controller: _dateOfBirthController,
                      ),
                      CustomTextField(
                        title: "Email",
                        icon: Icons.email,
                      ),
                      CustomTextField(
                        title: "Phone Number",
                        icon: Icons.phone,
                      ),
                      CustomTextField(
                        title: "Address",
                        icon: Icons.location_on,
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
