import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class PasswordTextBox extends StatelessWidget {
  PasswordTextBox({this.onChange});

  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      obscureText: true,
      onChanged: this.onChange,
      decoration: kInputDecoration.copyWith(hintText: 'Enter your password'),
    );
  }
}
