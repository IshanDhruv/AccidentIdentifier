import 'package:accident_identifier/presentation/auth/sign_in_screen.dart';
import 'package:accident_identifier/presentation/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn)
      return SignInScreen(toggleView: toggleView);
    else
      return SignUpScreen(toggleView: toggleView);
  }
}
