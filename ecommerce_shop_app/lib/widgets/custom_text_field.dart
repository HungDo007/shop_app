import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.title,
      required this.icon,
      this.controller,
      this.validate, this.inputType})
      : super(key: key);

  final String title;
  final IconData icon;
  final TextEditingController? controller;
  final validate;
  final TextInputType? inputType;

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
        controller: controller,
        validator: validate,
        keyboardType: inputType,
      ),
    );
  }
}
