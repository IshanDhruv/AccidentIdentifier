import 'package:accident_identifier/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({this.user});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accident Identifier"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => auth.signOut(),
          )
        ],
      ),
    );
  }
}
