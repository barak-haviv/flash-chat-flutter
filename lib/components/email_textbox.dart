import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class EmailTextBox extends StatelessWidget {
  EmailTextBox({this.onChange});
  final _textEditingController = TextEditingController();
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    _textEditingController.text = 'a@a.com';
    return TextField(
      controller: _textEditingController,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.emailAddress,
      onChanged: this.onChange,
      decoration: kInputDecoration.copyWith(hintText: 'Enter your email'),
    );
  }
}
