import 'package:flutter/material.dart';

Widget customTextFormField(
    TextEditingController controller,
    bool hasautofocus,
    TextInputType keyboardType,
    String errorMessage,
    int maxLength,
    String hintText) {
  return TextFormField(
    controller: controller,
    autofocus: hasautofocus,
    keyboardType: keyboardType,
    maxLength: maxLength,
    decoration: InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      contentPadding: const EdgeInsets.symmetric(
          vertical: 15, horizontal: 10), // Increase the padding
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return errorMessage;
      }
      return null;
    },
  );
}
