import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LodingSpinner extends StatelessWidget {
  const LodingSpinner({this.child, this.inAsyncCall});
  final Widget child;
  final bool inAsyncCall;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        progressIndicator: SpinKitChasingDots(
          color: Colors.lightBlue[300],
          size: 100.0,
        ),
        inAsyncCall: this.inAsyncCall,
        child: child);
  }
}
