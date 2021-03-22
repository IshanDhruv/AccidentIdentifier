import 'package:accident_identifier/presentation/auth/authenticate.dart';
import 'package:accident_identifier/presentation/home_screen.dart';
import 'package:accident_identifier/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user != null) {
            return HomeScreen(user: user);
          }
    return Authenticate();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      );
  }
}
