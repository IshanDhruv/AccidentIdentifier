import 'package:accident_identifier/models/contact.dart';
import 'package:accident_identifier/models/hospital.dart';
import 'package:accident_identifier/models/user.dart';
import 'package:accident_identifier/providers/user_provider.dart';
import 'package:accident_identifier/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  int _state = 0;
  var _user;
  UserRepository _userRepo;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        _user = watch(userProvider);
        _userRepo = watch(userServicesProvider);
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
    return Scaffold(
      body: Container(
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
                    color: _state == 0 ? Colors.black : Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Friends and Family",
                      style: TextStyle(
                        color: _state == 0 ? Colors.white : Colors.black,
                      ),
                    ),
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
                      color: _state == 1 ? Colors.black : Colors.white,
                      border: Border.all(),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      )),
                  child: Center(
                    child: Text(
                      "Hospitals",
                      style: TextStyle(
                        color: _state == 1 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Builder(
            builder: (context) {
              if (_state == 0)
                return _friendsUI(user);
              else
                return _hospitalsUI(user);
            },
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.person_add),
      ),
    );
  }

  Widget _friendsUI(CustomUser user) {
    List<Contact> _contacts = [
      Contact(
          name: "Harshul", phoneNumber: "+911234567890", relation: "Brother"),
      Contact(
          name: "Harshul", phoneNumber: "+911234567890", relation: "Friend"),
    ];
    print("userss");
    print(user.contacts.length);
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
                  user.contacts.length.toString(),
                  style: TextStyle(fontSize: 24),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_contacts[index].relation),
                    Text(_contacts[index].phoneNumber),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _hospitalsUI(CustomUser user) {
    List<Hospital> _hospitals = [
      Hospital(
          title: "Presbyterian Hospital",
          location: 'New York metropolitan area',
          phoneNumber: "+911234567890"),
      Hospital(
          title: "Presbyterian Hospital",
          location: 'New York metropolitan area',
          phoneNumber: "+911234567890"),
    ];
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _hospitals.length,
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
                  _hospitals[index].title,
                  style: TextStyle(fontSize: 24),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_hospitals[index].location),
                    Text(_hospitals[index].phoneNumber),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
