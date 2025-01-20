import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final int maxLength;
  final String errorMessage;
  final TextInputType keyboardType;
  final bool isNumeric;
  final bool hasAutofocus;
  final GlobalKey<FormState> formKey;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.label,
    required this.maxLength,
    required this.errorMessage,
    required this.keyboardType,
    required this.isNumeric,
    required this.hasAutofocus,
    required this.formKey,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        autofocus: hasAutofocus,
        key: formKey,
        keyboardType: keyboardType,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 15, horizontal: 10), // Increase the padding
        ),
        validator: validator);
  }
}
