import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: (56),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: press != null
              ? const Color(0xFFFF7643)
              : const Color.fromARGB(255, 158, 160, 166),
        ),
        onPressed: press,
        child: text != null
            ? Text(
                text!,
                style: const TextStyle(
                  fontSize: (18),
                  color: Colors.white,
                ),
              )
            : const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
