import 'package:accident_identifier/models/user.dart';
import 'package:accident_identifier/providers/auth_providers.dart';
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
      final _userState = watch(userProvider);
      return _userState.when(
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
            child: Text(error.toString()),
          );
        },
      );
    });
  }

  Widget _userProfile(CustomUser user) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 80),
          Container(),
          Text(user.name),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
