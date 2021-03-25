import 'package:accident_identifier/providers/auth_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final _authState = watch(authStateProvider);
      return _authState.when(
        data: (value) {
          if (value != null)
            return _userProfile(value);
          else
            return Center(
              child: Text("Something went wrong. :("),
            );
        },
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          return Center(
            child: Text("Something went wrong. :("),
          );
        },
      );
    });
  }

  Widget _userProfile(User user) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 80),
          Container(),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              user.photoURL,
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
