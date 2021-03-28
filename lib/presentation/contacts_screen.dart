import 'package:accident_identifier/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final _user = watch(userProvider);
        return _user.when(
          data: (value) {
            if (value != null)
              return Center(
                child: Text(value.email),
              );
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
      },
    );
  }
}
