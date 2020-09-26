import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/rounded_button.dart';

import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _colorAnimation;
  Animation _logoAnimation;

  @override
  initState() {
    super.initState();
    animate();
  }

  void animate() {
    AnimationStatus _animationStatus;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animationController.forward();

    _colorAnimation = ColorTween(begin: Colors.red, end: Colors.blue)
        .animate(_animationController);
    _logoAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.decelerate);

    _animationController.addStatusListener((status) {
      _animationStatus = status;
    });

    _animationController.addListener(() {
      setState(() {});
      print(_colorAnimation.value);
      print(_logoAnimation.value);
    });
  }

  void toggleAnimation() {
    _animationController.reverse(from: 1);
    // print(_animationStatus);
    // if(_animationStatus == AnimationStatus.completed) {
    //   _controller.reverse(from: 1);
    // } else if (_animationStatus == AnimationStatus.dismissed) {
    //   _controller.forward();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,

      backgroundColor: _colorAnimation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: _logoAnimation.value * 60,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 250),
                  totalRepeatCount: 2,
                  pause: Duration(milliseconds: 1000),
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              text: 'Log In',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              color: Colors.blueAccent,
              text: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
