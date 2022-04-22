import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../utils/http_exception.dart';

class SignUpPage extends StatefulWidget {
  // const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with InputValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final Map<String, String> _signUpData = {
    'username': '',
    'email': '',
    'password': '',
  };

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState?.save();
    try {
      await Provider.of<Auth>(context, listen: false).signUp(
        _signUpData["username"] ?? "",
        _signUpData["email"] ?? "",
        _signUpData["password"] ?? "",
      );
      Navigator.pushNamed(context, "/sign-in");
    } on HttpException catch (error) {
      var errorMessage = "Sign up failed";
      if (error
          .toString()
          .contains("Username already used-Email already used")) {
        errorMessage = "Username and email already used";
      } else if (error.toString().contains("Email already used")) {
        errorMessage = "Email already used";
      } else if (error.toString().contains("Username already used")) {
        errorMessage = "Username already used";
      }
      print(errorMessage);
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'StudentShop',
                      style: TextStyle(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (!isUsernameValid(value)) {
                        return 'Username is not valid';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _signUpData["username"] = value!;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (!isEmailValid(value)) {
                        return 'Email is not valid';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _signUpData["email"] = value!;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (!isPasswordValid(value)) {
                        return 'Password has at least 8 character with special character, number and uppercase character';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _signUpData["password"] = value!;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match!';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Sign Up'),
                      onPressed: _submit,
                    )),
                Row(
                  children: <Widget>[
                    const Text('Have an account?'),
                    TextButton(
                      child: const Text(
                        'Sign In',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

mixin InputValidationMixin {
  bool isUsernameValid(String username) {
    final usernameRegex = RegExp(r'^[a-zA-Z0-9]+$');
    return usernameRegex.hasMatch(username);
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    final passwordRegex = RegExp(
        r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])[0-9a-zA-Z!@#$%^&*]{8,}$');
    return passwordRegex.hasMatch(password);
  }
}
