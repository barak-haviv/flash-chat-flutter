import 'package:flash_chat/components/rounded_textbox.dart';
import 'package:flutter/material.dart';

class EmailTextBox extends StatelessWidget {
  EmailTextBox({this.onChange, this.initialValue = ''});

  final onChange;
  final initialValue;
  final textEditingController = TextEditingController();

  String get text {
    return textEditingController.text;
  }

  Widget build(BuildContext context) {
    textEditingController.text = initialValue;

    return RoundedTextBox(
      onChange: this.onChange,
      controller: textEditingController,
      hintText: 'Enter your email',
    );
  }
}

// class EmailTextBox extends StatelessWidget {
//   EmailTextBox({this.onChange, this.initValue});

//   final emailController = TextEditingController();
//   final String initValue;

//   final Function onChange;

//   @override
//   Widget build(BuildContext context) {
//     emailController.text = this.initValue;

//     return TextField(
//       controller: emailController,
//       textAlign: TextAlign.center,
//       keyboardType: TextInputType.emailAddress,
//       onChanged: this.onChange,
//       decoration: kInputDecoration.copyWith(hintText: 'Enter your email'),
//     );
//   }
// }
