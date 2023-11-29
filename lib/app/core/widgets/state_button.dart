import 'package:flutter/material.dart';

class StateButton extends StatelessWidget {
  const StateButton(
      {Key? key,
      required this.isLoading,
      required this.text,
      required this.onPressed})
      : super(key: key);
  final bool isLoading;
  final String text;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading ? const CircularProgressIndicator() : Text(text));
  }
}
