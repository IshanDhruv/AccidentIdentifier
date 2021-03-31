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
  var _userStream;
  var _contactsStream;
  var _hospitalsStream;
  UserRepository _userRepo;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        _userStream = watch(userProvider);
        _contactsStream = watch(contactsProvider);
        _hospitalsStream = watch(hospitalsProvider);
        _userRepo = watch(userServicesProvider);
        return _userStream.when(
          data: (user) {
            if (user != null)
              return _contactsUI(user);
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
        child: SingleChildScrollView(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showInputDialog(_state);
        },
        child: Icon(Icons.person_add),
      ),
    );
  }

  Widget _friendsUI(CustomUser user) {
    return _contactsStream.when(
      data: (contacts) {
        if (contacts != null) {
          if (contacts.isNotEmpty)
            return ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () async {
                    await _userRepo.deleteContact(contacts[index].id);
                  },
                  child: Container(
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
                          contacts[index].name,
                          style: TextStyle(fontSize: 24),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(contacts[index].relation ?? 'Friend'),
                            Text(contacts[index].phoneNumber ?? ''),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          else
            return Center(
              child: Text("Please add a contact."),
            );
        } else
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
  }

  Widget _hospitalsUI(CustomUser user) {
    return _hospitalsStream.when(
      data: (hospitals) {
        if (hospitals != null) {
          if (hospitals.isNotEmpty)
            return Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: hospitals.length,
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
                          hospitals[index].name,
                          style: TextStyle(fontSize: 24),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(hospitals[index].location ?? ''),
                            Text(hospitals[index].phoneNumber ?? ''),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          else
            return Center(
              child: Text("Please add a hospital."),
            );
        } else
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
  }

  _showInputDialog(int state) {
    String _name;
    String _email;
    String _phoneNumber;
    String _address;

    if (state == 0)
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Add Contact"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: new InputDecoration(hintText: "Name"),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              TextField(
                decoration: new InputDecoration(hintText: "Email"),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              TextField(
                decoration: new InputDecoration(hintText: "Phone  Number"),
                onChanged: (value) {
                  setState(() {
                    _phoneNumber = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              child: Text('Add Contact'),
              onPressed: () {
                setState(() {
                  _userRepo.addContact(_name, _email, _phoneNumber);
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      );
    else
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Add Hospital"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: new InputDecoration(hintText: "Name"),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              TextField(
                decoration: new InputDecoration(hintText: "Email"),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              TextField(
                decoration: new InputDecoration(hintText: "Phone  Number"),
                onChanged: (value) {
                  setState(() {
                    _phoneNumber = value;
                  });
                },
              ),
              TextField(
                decoration: new InputDecoration(hintText: "Address"),
                onChanged: (value) {
                  setState(() {
                    _address = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              child: Text('Add Hospital'),
              onPressed: () {
                setState(() {
                  _userRepo.addHospital(_name, _email, _phoneNumber, _address);
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      );
  }
}
