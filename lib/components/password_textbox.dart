import 'package:flash_chat/components/rounded_textbox.dart';
import 'package:flutter/material.dart';

class PasswordTextBox extends StatelessWidget {
  PasswordTextBox({this.onChange, this.initialValue});

  final Function onChange;
  final String initialValue;
  final textEditingController = TextEditingController();

  String get text {
    return textEditingController.text;
  }

  @override
  Widget build(BuildContext context) {
    textEditingController.text = initialValue;
    return RoundedTextBox(
      obscureText: true,
      onChange: this.onChange,
      controller: textEditingController,
      hintText: 'Enter your password',
    );
  }
}
