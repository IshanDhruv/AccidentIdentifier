import 'package:accident_identifier/services/api_response.dart';
import 'package:accident_identifier/services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final UserController _controller = Get.find<UserController>();
  int _state = 0;

  @override
  void initState() {
    _controller.getContacts();
    _controller.getHospitals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _contactsUI();
  }

  Widget _contactsUI() {
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
                  return _friendsUI();
                else
                  return _hospitalsUI();
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

  Widget _friendsUI() {
    return Container(
      child: Obx(() {
        switch (_controller.contactDetails.status) {
          case Status.INIT:
            break;
          case Status.LOADING:
            return Center(child: CircularProgressIndicator());
            break;
          case Status.ERROR:
            debugPrint(_controller.contactDetails.message);
            return Center(
              child: Container(
                margin: EdgeInsets.all(32),
                child: Text(
                  _controller.contactDetails.message,
                  textAlign: TextAlign.center,
                ),
              ),
            );
            break;
          case Status.COMPLETED:
            var contacts = _controller.contacts.value;
            return ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: contacts.length,
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
                  );
                });
            break;
        }
        return Container();
      }),
    );
  }

  Widget _hospitalsUI() {
    return Container(
      child: Obx(() {
        switch (_controller.hospitalDetails.status) {
          case Status.INIT:
            break;
          case Status.LOADING:
            return Center(child: CircularProgressIndicator());
            break;
          case Status.ERROR:
            debugPrint(_controller.hospitalDetails.message);
            return Center(
              child: Container(
                margin: EdgeInsets.all(32),
                child: Text(
                  _controller.hospitalDetails.message,
                  textAlign: TextAlign.center,
                ),
              ),
            );
            break;
          case Status.COMPLETED:
            var hospitals = _controller.hospitals.value;
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
            break;
        }
        return Container();
      }),
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
                _controller
                    .addContact(_name, _email, _phoneNumber)
                    .then((value) {
                  if (value == true) _controller.getContacts();
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
              onPressed: () {},
            ),
          ],
        ),
      );
  }
}
