import 'package:flash_chat/components/rounded_textbox.dart';
import 'package:flutter/material.dart';

class EmailTextBox extends StatelessWidget with RoundedTextBoxEditing {
  EmailTextBox({this.onChange, this.initialValue = ''});

  final onChange;
  final initialValue;

  Widget build(BuildContext context) {
    textEditingController.text = initialValue;

    return RoundedTextBox(
      onChange: this.onChange,
      controller: textEditingController,
      hintText: 'Enter your email',
    );
  }
}
