import 'package:accident_identifier/models/user.dart';
import 'package:accident_identifier/providers/user_provider.dart';
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
              return _contactsUI(value);
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

  Widget _contactsUI(CustomUser user) {
    int _state = 0;
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _state = 0;
                });
              },
              child: Container(
                width: 150,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text("Friends and Family"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _state = 1;
                });
              },
              child: Container(
                width: 150,
                height: 30,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    )),
                child: Center(
                  child: Text("Hospitals"),
                ),
              ),
            ),
          ],
        ),
        _friendsUI(user)
      ]),
    );
  }

  Widget _friendsUI(CustomUser user) {
    List<CustomUser> _contacts = [
      CustomUser(name: "Harshul", phoneNumber: "+911234567890"),
      CustomUser(name: "Harshul", phoneNumber: "+911234567890"),
    ];
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _contacts[index].name,
                  style: TextStyle(fontSize: 24),
                ),
                Text(_contacts[index].phoneNumber),
              ],
            ),
          );
        },
      ),
    );
  }
}
