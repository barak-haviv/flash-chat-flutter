import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

mixin RoundedTextBoxEditing {
  final textEditingController = TextEditingController();
  String get text {
    return textEditingController.text;
  }
}

class RoundedTextBox extends StatelessWidget {
  RoundedTextBox({
    this.initialValue,
    this.hintText,
    this.controller,
    this.onChange,
    this.obscureText = false,
    this.keyboardType,
  });

  final bool obscureText;
  final Function onChange;
  final String initialValue;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      textAlign: TextAlign.center,
      keyboardType: this.keyboardType,
      onChanged: this.onChange,
      controller: this.controller,
      decoration: kInputDecoration.copyWith(hintText: this.hintText),
    );
  }
}
