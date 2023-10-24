import 'package:ace_flash/theme/pallete.dart';
import 'package:flutter/material.dart';

class MultiLineAuthField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  const MultiLineAuthField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 5, // Adjust the number of lines as needed
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Pallete.blueColor,
            width: 3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Pallete.greyColor,
          ),
        ),
        contentPadding: const EdgeInsets.all(22),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 18,
          color: Pallete.lightBlueColor,
        ),
      ),
    );
  }
}
