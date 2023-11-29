import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    required this.onChanged,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.disable = false,
    this.showBorder = false,
    Key? key,
  }) : super(key: key);
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool showBorder;
  final bool disable;
  final TextInputType textInputType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String) onChanged;
  OutlineInputBorder outlineInputBorder() {
    if (showBorder) {
      return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(15),
      );
    } else {
      return OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextFormField(
          enabled: !disable,
          keyboardType: textInputType,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            enabledBorder: outlineInputBorder(),
            focusedBorder: outlineInputBorder(),
            errorBorder: outlineInputBorder(),
            focusedErrorBorder: outlineInputBorder(),
            disabledBorder: outlineInputBorder(),
            border: outlineInputBorder(),
            fillColor: Colors.grey[300],
            hintText: hint,
          ),
          controller: controller,
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
