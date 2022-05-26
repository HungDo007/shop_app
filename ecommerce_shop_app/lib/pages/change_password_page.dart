import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './sign-in-page.dart';

import '../providers/user.dart';
import '../providers/auth.dart';

import '../widgets/custom_button.dart';

import '../utils/input_validation.dart';
import '../utils/http_exception.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage>
    with InputValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _oldPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _hidePassword = true;

  Widget _buildTextFormField(
      TextEditingController controller, String title, validator) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        obscureText: _hidePassword,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: title,
          prefixIcon: const Icon(Icons.person_pin),
          suffixIcon: IconButton(
              onPressed: _handleHidePassword,
              icon: Icon(
                  _hidePassword ? Icons.visibility : Icons.visibility_off)),
        ),
        validator: validator,
      ),
    );
  }

  void _handleHidePassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      var payload = {
        "oldPassword": _oldPassController.text,
        "newPassword": _newPassController.text,
      };
      try {
        await UserMethod().changePassword(payload);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Theme.of(context).primaryColor),
                const SizedBox(
                  width: 10,
                ),
                const Text('Change password successfully!'),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            backgroundColor: Colors.grey,
            duration: const Duration(milliseconds: 1500),
          ),
        );
        Future.delayed(const Duration(seconds: 2), () {
          Provider.of<Auth>(context, listen: false).signOut();
          Navigator.pushReplacementNamed(context, SignInPage.routeName);
        });
      } on HttpException catch (error) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Error"),
            content: Text(error.toString()),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      } catch (e) {
        rethrow;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text("Change Password"),
                  _buildTextFormField(
                    _oldPassController,
                    "Old Password",
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (!isPasswordValid(value)) {
                        return 'Password has at least 8 character with special character, number and uppercase character';
                      }
                      return null;
                    },
                  ),
                  _buildTextFormField(
                    _newPassController,
                    "New Password",
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (!isPasswordValid(value)) {
                        return 'Password has at least 8 character with special character, number and uppercase character';
                      }
                      return null;
                    },
                  ),
                  _buildTextFormField(
                      _confirmPassController, "Confirm Password", (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    } else if (value != _newPassController.text) {
                      return 'Passwords do not match!';
                    }
                    return null;
                  }),
                  CustomButton(
                    text: "Submit",
                    press: _submit,
                  ),
                ],
              ),
            ),
          ),
        ),
        const Expanded(child: SizedBox())
      ],
    );
  }
}
