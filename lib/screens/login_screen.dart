import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/email_textbox.dart';
import 'package:flash_chat/components/loading.dart';
import 'package:flash_chat/components/password_textbox.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextBox = EmailTextBox(initialValue: 'testme2@gmail.com');
  final _passwordTextBox = PasswordTextBox(initialValue: 'Some33Pass');
  bool _inAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: LodingSpinner(
          inAsyncCall: _inAsyncCall,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                _emailTextBox,
                SizedBox(
                  height: 8.0,
                ),
                _passwordTextBox,
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  color: Colors.lightBlueAccent,
                  text: 'Log In',
                  onPressed: () {
                    print('email: ${_emailTextBox.text}');
                    print('password: ${_passwordTextBox.text}');
                    signIn(_emailTextBox.text, _passwordTextBox.text);
                  },
                ),
              ],
            ),
          ),
        ));
  }

  void signIn(email, password) async {
    print('signIn method $email, $password');
    try {
      setState(() => _inAsyncCall = true);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('login succeded with user creds $userCredential');
      setState(() => _inAsyncCall = false);
      Navigator.pushNamed(context, ChatScreen.id);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
