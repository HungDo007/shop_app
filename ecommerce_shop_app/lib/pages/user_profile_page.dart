import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../api/api_url.dart';
import '../providers/user.dart';
import '../utils/input_validation.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with InputValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  String _avatar = "";
  File? _imageFile;
  late Future<User> _userFuture;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990, 1),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dateOfBirthController.text = DateFormat("MM/dd/yyyy").format(picked);
      });
    }
  }

  Future<User> getUser() async {
    final user = await UserMethod().getUser();
    setState(() {
      _firstNameController.text = user.firstName;
      _lastNameController.text = user.lastName;
      _dateOfBirthController.text =
          DateFormat("MM/dd/yyyy").format(DateTime.parse(user.birthDay));
      _emailController.text = user.email;
      _phoneNumberController.text = user.phoneNumber;
      _addressController.text = user.address;
      _avatar = user.avatar;
    });
    return user;
  }

  @override
  void initState() {
    _userFuture = getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: _userFuture,
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
                                backgroundImage: _imageFile != null
                                    ? FileImage(_imageFile!)
                                    : NetworkImage(
                                        ApiUrls.baseUrl + _avatar,
                                      ) as ImageProvider,
                                backgroundColor: const Color(0xFFDADADA),
                              ),
                              Positioned(
                                right: -12,
                                bottom: -18,
                                child: SizedBox(
                                  height: 46,
                                  width: 46,
                                  child: TextButton(
                                    onPressed: () async {
                                      final ImagePicker _picker = ImagePicker();
                                      final XFile? image =
                                          await _picker.pickImage(
                                              source: ImageSource.gallery);
                                      setState(() {
                                        _imageFile = File(image!.path);
                                      });
                                    },
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
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              CustomTextField(
                                title: "First Name",
                                icon: Icons.account_circle,
                                controller: _firstNameController,
                                validate: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "This field is required";
                                  }
                                  return null;
                                },
                              ),
                              CustomTextField(
                                title: "Last Name",
                                icon: Icons.account_circle,
                                controller: _lastNameController,
                                validate: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "This field is required";
                                  }
                                  return null;
                                },
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
                                controller: _emailController,
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required';
                                  } else if (!isEmailValid(value)) {
                                    return 'Email is not valid';
                                  }
                                  return null;
                                },
                              ),
                              CustomTextField(
                                title: "Phone Number",
                                icon: Icons.phone,
                                controller: _phoneNumberController,
                                validate: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required';
                                  } else if (!isPhoneValid(value)) {
                                    return 'Phone number is not valid';
                                  }
                                  return null;
                                },
                              ),
                              CustomTextField(
                                title: "Address",
                                icon: Icons.location_on,
                                controller: _addressController,
                                validate: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "This field is required";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomButton(
                                text: "Save Changes",
                                press: () async {
                                  if (_formKey.currentState!.validate()) {
                                    var user = userSnapshot.data as User;
                                    try {
                                      await UserMethod().editProfile(
                                          User(
                                            id: "",
                                            username: user.username,
                                            firstName:
                                                _firstNameController.text,
                                            lastName: _lastNameController.text,
                                            birthDay:
                                                _dateOfBirthController.text,
                                            email: _emailController.text,
                                            phoneNumber:
                                                _phoneNumberController.text,
                                            address: _addressController.text,
                                            avatar: "",
                                          ),
                                          _imageFile?.path ?? "");
                                    } catch (e) {
                                      print(e);
                                    }
                                  }
                                },
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
